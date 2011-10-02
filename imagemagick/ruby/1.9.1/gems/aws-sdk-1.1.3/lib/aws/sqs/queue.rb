# Copyright 2011 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

require 'aws/inflection'
require 'aws/model'
require 'aws/sqs/received_message'
require 'aws/sqs/received_sns_message'

module AWS
  class SQS

    # Represents an Amazon SQS Queue.
    #
    # @example Sending a message
    #   msg = queue.send_message("HELLO")
    #   puts "Sent message: #{msg.id}"
    #
    # @example Polling for messages indefinitely
    #   queue.poll do |msg|
    #     puts "Got message: #{msg.body}"
    #   end
    #
    class Queue

      # The default number of seconds to wait between polling requests for
      # new messages.  
      DEFAULT_POLL_INTERVAL = 1

      include Model

      # @return [String] The queue URL.
      attr_reader :url

      # @private
      def initialize(url, opts = {})
        @url = url
        super
      end

      # Deletes the queue, regardless of whether it is empty.  
      #
      # When you delete a queue, the deletion process takes up to 60
      # seconds. Requests you send involving that queue during the
      # 60 seconds might succeed. For example, calling
      # {#send_message} might succeed, but after the 60 seconds, the
      # queue and that message you sent no longer exist. 
      #
      # Also, when you delete a queue, you must wait at least 60 seconds 
      # before creating a queue with the same name.
      # @return [nil]
      def delete
        client.delete_queue(:queue_url => url)
        nil
      end

      # Represents a message sent using {Queue#send_message}.
      class SentMessage

        # @return [String] Returns the message ID.
        attr_accessor :message_id

        alias_method :id, :message_id

        # @return [String] Returns an MD5 digest of the message body 
        #   string.  You can use this to verify that SQS received your
        #   message correctly.
        attr_accessor :md5

      end

      # Delivers a message to this queue.
      #
      # @param [String] body The message to send.  The maximum
      #   allowed message size is 64 KB.  The message may only
      #   contain Unicode characters from the following list,
      #   according to the W3C XML specification (for more
      #   information, go to
      #   http://www.w3.org/TR/REC-xml/#charsets).  If you send any
      #   characters not included in the list, your request will be
      #   rejected.
      #
      #   * #x9
      #   * #xA
      #   * #xD
      #   * #x20 to #xD7FF
      #   * #xE000 to #xFFFD
      #   * #x10000 to #x10FFFF
      #
      # @return [SentMessage] An object containing information about
      #   the message that was sent.
      def send_message(body)
        resp = client.send_message(:queue_url => url,
                                   :message_body => body)
        msg = SentMessage.new
        msg.message_id = resp.message_id
        msg.md5 = resp.md5_of_message_body
        msg
      end

      # Retrieves one or more messages.  When a block is given, each
      # message is yielded to the block and then deleted as long as
      # the block exits normally.  When no block is given, you must
      # delete the message yourself using {ReceivedMessage#delete}.
      #
      # @note Due to the distributed nature of the queue, a weighted
      #   random set of machines is sampled on a ReceiveMessage
      #   call. That means only the messages on the sampled machines
      #   are returned. If the number of messages in the queue is
      #   small (less than 1000), it is likely you will get fewer
      #   messages than you requested per call to
      #   {#receive_message}. If the number of messages in the queue
      #   is extremely small, you might not receive any messages.
      #   To poll continually for messages, use the {#poll} method,
      #   which automatically retries the request after a
      #   configurable delay.
      #
      # @param [Hash] opts Options for receiving messages.
      #
      # @option opts [Integer] :limit The maximum number of messages
      #   to receive.  By default this is 1, and the return value is
      #   a single message object.  If this options is specified and
      #   is not 1, the return value is an array of message objects;
      #   however, the array may contain fewer objects than you
      #   requested.  Valid values: integers from 1 to 10.
      #
      #   Not necessarily all the messages in the queue are returned
      #   (for more information, see the preceding note about
      #   machine sampling).
      #
      # @option opts [Integer] :visibilitiy_timeout The duration (in
      #   seconds) that the received messages are hidden from
      #   subsequent retrieve requests.  Valid values: integer from
      #   0 to 43200 (maximum 12 hours)
      #
      # @option opts [Array<Symbol, String>] :attributes The
      #   attributes to populate in each received message.  Valid values:
      #
      #   * +:all+ (to populate all attributes)
      #   * +:sender_id+
      #   * +:sent_at+
      #   * +:receive_count+
      #   * +:first_received_at+
      #
      #   See {ReceivedMessage} for documentation on each
      #   attribute's meaning.
      #
      # @yieldparam [ReceivedMessage] message Each message that was received.
      #
      # @return [ReceivedMessage] Returns the received message (or messages)
      #   only if a block is not given to this method.
      #
      def receive_message(opts = {}, &block)
        resp = client.receive_message(receive_opts(opts))

        messages = resp.messages.map do |m|
          ReceivedMessage.new(self, m.message_id, m.receipt_handle,
                              :body => m.body,
                              :md5 => m.md5_of_body,
                              :attributes => m.attributes)
        end

        if block
          call_message_block(messages, block)
        elsif opts[:limit] && opts[:limit] != 1
          messages
        else
          messages.first
        end
      end
      alias_method :receive_messages, :receive_message

      # Polls continually for messages.  For example, you can use
      # this to poll indefinitely:
      #
      #  queue.poll { |msg| puts msg.body }
      #
      # Or, to poll indefinitely for the first message and then
      # continue polling until no message is received for a period
      # of at least ten seconds:
      #
      #  queue.poll(:initial_timeout => false,
      #             :idle_timeout => 10) { |msg| puts msg.body }
      #
      # As with the block form of {#receive_message}, this method
      # automatically deletes the message then the block exits
      # normally.
      #
      # @yieldparam [ReceivedMessage] message Each message that was received.
      #
      # @param [Hash] opts Options for polling.
      #
      # @option opts [Float, Integer] :poll_interval The number of
      #   seconds to wait before retrying when no messages are
      #   received.  The default is 1 second.
      #
      # @option opts [Integer] :idle_timeout The maximum number of
      #   seconds to spend polling while no messages are being
      #   returned.  By default this method polls indefinitely
      #   whether messages are received or not.
      #
      # @option opts [Integer] :initial_timeout The maximum number
      #   of seconds to spend polling before the first message is
      #   received.  This option defaults to the value of
      #   +:idle_timeout+.  You can specify +false+ to poll
      #   indefinitely for the first message when +:idle_timeout+ is
      #   set.
      #
      # @option opts [Integer] :batch_size The maximum number of
      #   messages to retrieve in a single request.  By default
      #   messages are received one at a time.  Valid values:
      #   integers from 1 to 10.
      #
      # @option opts [Integer] :visibilitiy_timeout The duration (in
      #   seconds) that the received messages are hidden from
      #   subsequent retrieve requests.  Valid values: integer from
      #   0 to 43200 (maximum 12 hours)
      #
      # @option opts [Array<Symbol, String>] :attributes The
      #   attributes to populate in each received message.  Valid values:
      #
      #   * +:all+ (to populate all attributes)
      #   * +:sender_id+
      #   * +:sent_at+
      #   * +:receive_count+
      #   * +:first_received_at+
      #
      #   See {ReceivedMessage} for documentation on each
      #   attribute's meaning.
      #
      # @return [nil]
      def poll(opts = {}, &block)
        poll_interval = opts[:poll_interval] || DEFAULT_POLL_INTERVAL
        opts[:limit] = opts.delete(:batch_size) if
          opts.key?(:batch_size)

        last_message_at = Time.now
        got_first = false
        loop do
          got_msg = false
          receive_messages(opts) do |message|
            got_msg = got_first = true
            last_message_at = Time.now
            yield(message)
          end
          unless got_msg
            Kernel.sleep(poll_interval) unless poll_interval == 0
            return if hit_timeout?(got_first, last_message_at, opts)
          end
        end
        nil
      end

      # @return [Integer] The approximate number of visible messages
      #   in a queue.  For more information, see {Resources Required
      #   to Process
      #   Messages}[http://docs.amazonwebservices.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/IntroductionArticle.html#ApproximateNumber]
      #   in the Amazon SQS Developer Guide.
      def approximate_number_of_messages
        get_attribute("ApproximateNumberOfMessages").to_i
      end
      alias_method :visible_messages, :approximate_number_of_messages

      # @return [Integer] The approximate number of messages that
      #   are not timed-out and not deleted.  For more information,
      #   see {Resources Required to Process
      #   Messages}[http://docs.amazonwebservices.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/IntroductionArticle.html#ApproximateNumber]
      #   in the Amazon SQS Developer Guide.
      def approximate_number_of_messages_not_visible
        get_attribute("ApproximateNumberOfMessagesNotVisible").to_i
      end
      alias_method :invisible_messages, :approximate_number_of_messages_not_visible

      # @return [Integer] Returns the visibility timeout for the
      #   queue. For more information about visibility timeout, see
      #   {Visibility
      #   Timeout}[http://docs.amazonwebservices.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/IntroductionArticle.html#AboutVT]
      #   in the Amazon SQS Developer Guide.
      def visibility_timeout
        get_attribute("VisibilityTimeout").to_i
      end

      # Sets the visibility timeout for the queue.
      #
      # @param [Integer] timeout The length of time (in seconds)
      #   that a message received from a queue will be invisible to
      #   other receiving components when they ask to receive
      #   messages.  Valid values: integers from 0 to 43200 (12
      #   hours).
      #
      # @return Returns the value passed as a timeout.
      def visibility_timeout=(timeout)
        set_attribute("VisibilityTimeout", timeout.to_s)
        timeout
      end

      # @return [Time] The time when the queue was created.
      def created_timestamp
        Time.at(get_attribute("CreatedTimestamp").to_i)
      end

      # @return [Time] The time when the queue was last changed.
      def last_modified_timestamp
        Time.at(get_attribute("LastModifiedTimestamp").to_i)
      end

      # @return [Integer] The limit of how many bytes a message can
      #   contain before Amazon SQS rejects it.
      def maximum_message_size
        get_attribute("MaximumMessageSize").to_i
      end

      # Sets the maximum message size for the queue.
      #
      # @param [Integer] size The limit of how many bytes a message
      #   can contain before Amazon SQS rejects it.  This must be an
      #   integer from 1024 bytes (1KB) up to 65536 bytes
      #   (64KB). The default for this attribute is 8192 (8KB).
      # @return Retuns the passed size argument.
      def maximum_message_size=(size)
        set_attribute("MaximumMessageSize", size.to_s)
      end

      # @return [Integer] The number of seconds Amazon SQS retains a
      #   message.
      def message_retention_period
        get_attribute("MessageRetentionPeriod").to_i
      end

      # Sets the message retention period for the queue
      #
      # @param [Integer] period The number of seconds Amazon SQS
      #   retains a message.  Must be an integer from 3600 (1 hour)
      #   to 1209600 (14 days). The default for this attribute is
      #   345600 (4 days).
      # @return Returns the passed period argument.
      def message_retention_period=(period)
        set_attribute("MessageRetentionPeriod", period.to_s)
        period
      end

      # @return [String] The queue's Amazon resource name (ARN).
      def arn
        @arn ||= get_attribute("QueueArn")
      end

      # @return [Boolean] True if the queue exists.
      #
      # @note This may raise an exception if you don't have
      #   permission to access the queue attributes.  Also, it may
      #   return true for up to 60 seconds after a queue has been
      #   deleted.
      def exists?
        client.get_queue_attributes(:queue_url => url,
                                    :attribute_names => ["QueueArn"])
      rescue Errors::NonExistentQueue, Errors::InvalidAddress
        false
      else
        true
      end

      # @private
      module PolicyProxy

        attr_accessor :queue

        def change
          yield(self)
          queue.policy = self
        end

        def delete
          queue.client.send(:set_attribute, 'Policy', '')
        end

      end

      # @return [Policy] Returns the current queue policy if there is one.
      #   Returns +nil+ otherwise.
      def policy
        if policy_json = get_attribute('Policy')
          policy = SQS::Policy.from_json(policy_json)
          policy.extend(PolicyProxy)
          policy.queue = self
          policy
        else
          nil
        end
      end
      
      # Set the policy on this queue.
      #
      # If you pass nil or an empty string then it will have the same 
      # effect as deleting the policy.
      #
      # @param policy The policy to set.  This policy can be a {Policy} object,
      #   a json policy string, or any other object that responds with a policy
      #   string when it received #to_json.
      #
      # @return [nil]
      def policy= policy
        policy_string = case policy
        when nil, '' then ''
        when String  then policy
        else policy.to_json
        end
        set_attribute('Policy', policy_string)
        nil
      end

      # @return [Boolean] Returns true if the other queue has the same
      #   url.
      def ==(other)
        other.kind_of?(Queue) and other.url == url
      end
      alias_method :eql?, :==

      # @private
      def inspect
        "<#{self.class}:#{url}>"
      end

      # @private
      protected
      def hit_timeout?(got_first, last_message_at, opts)
        initial_timeout = opts[:initial_timeout]
        idle_timeout = opts[:idle_timeout]

        timeout = (got_first ||
                   # if initial_timeout is false (as opposed
                   # to nil) then we skip the branch and poll
                   # indefinitely until the first message
                   # comes
                   (!initial_timeout && initial_timeout != false) ?
                   idle_timeout :
                   initial_timeout) and
          Time.now - last_message_at > timeout
      end

      # @private
      protected
      def receive_opts(opts)
        receive_opts = { :queue_url => url }
        receive_opts[:visibility_timeout] = opts[:visibility_timeout] if
          opts[:visibility_timeout]
        receive_opts[:max_number_of_messages] = opts[:limit] if
          opts[:limit]
        if names = opts[:attributes]
          receive_opts[:attribute_names] = names.map do |name|
            name = ReceivedMessage::ATTRIBUTE_ALIASES[name.to_sym] if
              ReceivedMessage::ATTRIBUTE_ALIASES.key?(name.to_sym)
            name = Inflection.class_name(name.to_s) if name.kind_of?(Symbol)
            name
          end
        end
        receive_opts
      end

      # @private
      protected
      def call_message_block(messages, block)
        result = nil
        messages.each do |message|
          begin
            result = block.call(message)
          rescue Exception => e
            raise
          else
            message.delete
          end
        end
        result
      end

      # @private
      protected
      def get_attribute(name)
        resp = client.get_queue_attributes(:queue_url => url,
                                           :attribute_names =>
                                           [name, "QueueArn"].uniq)
        @arn ||= resp.attributes["QueueArn"]
        resp.attributes[name]
      end

      # @private
      protected
      def set_attribute(name, value)
        client.set_queue_attributes(:queue_url => url,
                                    :attribute => {
                                      :name => name,
                                      :value => value
                                    })
      end

    end

  end
end
