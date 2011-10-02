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

require 'json'
require 'aws/model'
require 'aws/sns/policy'
require 'aws/sns/subscription'
require 'aws/sns/topic_subscription_collection'
require 'aws/sqs'

module AWS
  class SNS

    class Topic

      include Model

      # @param [String] arn The topic ARN.
      def initialize arn, options = {}
        @arn = arn
        super
      end

      # @return [String] The topic ARN.
      attr_reader :arn

      # The topic name.  
      #
      # If you have not set a display name (see {#display_name=}) then 
      # this is used as the "From" field for notifications to email and 
      # email-json endpoints.  
      # @return [String] Returns the toipc name.  
      def name
        arn.split(/:/)[-1]
      end

      # Causes the given +endpoint+ to receive messages published to this
      # topic.
      #
      # == Subscribing to SQS Queues
      #
      # If you subscribe to an SQS queue (with a {SQS::Queue} object}
      # then a policy will be added/updated to the queue that will
      # permit this topic to send it messages.  Some important notes:
      #
      # * If you subscribe with a queue by ARN then you must change the
      #   policy yourself.
      #
      # * If you do not want the policy modified then pass +:update_policy+
      #   as false or just pass the queue's arn
      #
      #     topic.subscribe(queue.arn)
      #     topic.subscribe(queue, :update_policy => false)
      #
      # @example Using a url string to set the endpoint (http and https)
      #
      #    topic.subscribe('http://example.com/messages')
      #    topic.subscribe('https://example.com/messages')
      # 
      # @example Using a uri object to set the endpoint (http and https)
      #
      #    topic.subscribe(URI.parse('http://example.com/messages'))
      #    topic.subscribe(URI.parse('https://example.com/messages'))
      #
      # @example Email address as endpoint
      #
      #    topic.subscribe('nobody@example.com')
      #
      # @example Email address as a JSON endpoint
      #
      #    # send messages encoded as json object to the given email address
      #    topic.subscribe('nobody@example.com', :json => true)
      #
      # @example SQS Queue (by arn)
      #
      #    # you must manage the queue policy yourself to allow the
      #    # the topic to send messages (policy action 'sqs:SendMessage')
      #    topic.subscribe('arn:aws:sqs:us-east-1:123456789123:AQueue')
      #
      # @example SQS Queue (by Queue object)
      #
      #    # the queue policy will be added/updated to allow the topic
      #    # to send it messages
      #    topic.subscribe(AWS::SQS.new.queues.first)
      # 
      # @param [mixed] endpoint The endpoint that should receive
      #   messages that are published to this topic.  Valid values
      #   for +endpoint+ include:
      #   * URI object
      #   * http and https URI strings
      #   * email addresse
      #   * {SQS::Queue}
      #   * SQS queue ARN
      # @param [Hash] options
      # @option options [Boolean] :json (false)
      # @return [Subscription,nil] Returns a subscription when possible.
      #   If the subscription requires confirmation first, then +nil+ is
      #   returned instead.
      def subscribe(endpoint, opts = {})
        subscribe_opts = endpoint_opts(endpoint, opts).merge(:topic_arn => arn)
        resp = client.subscribe(subscribe_opts)
        if arn = resp.subscription_arn and arn =~ /^arn:/
          Subscription.new(arn, :config => config)
        else
          nil
        end
      end

      # Verifies an endpoint owner's intent to receive messages by
      # validating the token sent to the endpoint by an earlier
      # Subscribe action. If the token is valid, the action creates a
      # new subscription.
      #
      # @param [String] token Short-lived token sent to an endpoint
      #   during the {#subscribe} action.
      #
      # @param [Hash] options Additional options for confirming the
      #   subscription.
      #
      # @option :options [Boolean] :authenticate_on_unsubscribe
      #   Indicates that you want to disable unauthenticated
      #   unsubsciption of the subscription. If parameter is present
      #   in the request, the request has an AWS signature, and the
      #   value of this parameter is true, only the topic owner and
      #   the subscription owner will be permitted to unsubscribe the
      #   endpoint, and the Unsubscribe action will require AWS
      #   authentication.
      #
      # @return [Subscription] The newly created subscription.
      def confirm_subscription(token, opts = {})
        confirm_opts = opts.merge(:token => token, :topic_arn => arn)
        resp = client.confirm_subscription(confirm_opts)
        Subscription.new(
          resp.subscription_arn,
          :topic => self,
          :config => config)
      end

      # @return [TopicSubscriptionCollection] Returns a collection that
      #   represents all of the subscriptions for this topic.
      def subscriptions
        TopicSubscriptionCollection.new(self)
      end

      # @return [String] Returns the human-readable name used in 
      #   the "From" field for notifications to email and email-json 
      #   endpoints.  If you have not set the display name the topic
      #   {#name} will be used/returned instead.
      def display_name
        to_h[:display_name]
      end

      # @param [String] display_name Sets the human-readable name used in 
      #   the "From" field for notifications to email and email-json 
      #   endpoints.
      # @return [String] Returns the display_name as passed.
      def display_name= display_name
        set_attribute('DisplayName', display_name)
        display_name
      end

      # @return [String] The topic owner's ID.
      def owner
        to_h[:owner]
      end

      # @return [Integer] Returns number of confirmed topic subscriptions.
      def num_subscriptions_confirmed
        to_h[:num_subscriptions_confirmed]
      end

      # @return [Integer] Returns number of pending topic subscriptions.
      def num_subscriptions_pending
        to_h[:num_subscriptions_pending]
      end

      # @return [Integer] Returns number of deleted topic subscriptions.
      def num_subscriptions_deleted
        to_h[:num_subscriptions_deleted]
      end

      # @return [Policy] The topic's {Policy}.
      def policy
        to_h[:policy]
      end

      # Sets the topic's policy.  
      # @param [String,Policy] policy A JSON policy string, a {Policy} object
      #   or any other object that responds to #to_json with a valid 
      #   policy.
      # @return [nil]
      def policy= policy
        policy_json = policy.is_a?(String) ? policy : policy.to_json
        set_attribute('Policy', policy_json)
        nil
      end

      # Publishes a message to this SNS topic. 
      #
      #   topic.publish('a short message')
      #
      # You can pass a subject that is used when sending the message to
      # email endpoints:
      #
      #   topic.publish('message', :subject => 'SNS message subject')
      #
      # If you would like to pass a different message to various protocols
      # (endpoint types) you can pass those as options:
      #
      #   topic.publish('default message',
      #     :http => "message sent to http endpoints",
      #     :https => "message sent to https endpoints",
      #     :email => "message sent to email endpoints")
      #
      # The full list of acceptable protocols are listed below.  The default
      # message is sent to endpoints who's protocol was not listed.
      #
      # @param [String] default_message The message you want to send to the 
      #   topic.  Messages must be UTF-8 encoded strings at most 8 KB in size 
      #   (8192 bytes, not 8192 characters).
      # @param [Hash] Options
      # @option options [String] :subject Used as the "Subject" line when 
      #   the message is delivered to email endpoints. Will also  be
      #   included in the standard JSON messages delivered to other endpoints.
      #   * must be ASCII text that begins with a letter, number or 
      #     punctuation mark
      #   * must not include line breaks or control characters
      #   * and must be less than 100 characters long
      # @option options [String] :http - Message to use when sending to an 
      #   HTTP endpoint.
      # @option options [String] :https - Message to use when sending to an 
      #   HTTPS endpoint.
      # @option options [String] :email - Message to use when sending to an 
      #   email endpoint.
      # @option options [String] :email_json - Message to use when sending 
      #   to an email json endpoint.
      # @option options [String] :sqs - Message to use when sending to an 
      #   SQS endpoint.
      # @return [String] Returns the ID of the message that was sent.
      def publish default_message, options = {}

        message = { :default => default_message }

        [:http, :https, :email, :email_json, :sqs].each do |protocol|
          if options[protocol]
            message[protocol.to_s.gsub(/_/, '-')] = options[protocol]
          end
        end

        publish_opts = {}
        publish_opts[:message] = message.to_json
        publish_opts[:message_structure] = 'json'
        publish_opts[:subject] = options[:subject] if options[:subject]
        publish_opts[:topic_arn] = arn
        
        response = client.publish(publish_opts)

        response.message_id

      end

      # Deletes the topic.
      # @return [nil]
      def delete
        client.delete_topic(:topic_arn => arn)
        nil
      end

      # @return [Hash] Returns a hash of attributes about this topic,
      #   including:
      #
      #   * +:arn+
      #   * +:name+
      #   * +:owner+
      #   * +:display_name+
      #   * +:policy+
      #   * +:num_subscriptions_confirmed+
      #   * +:num_subscriptions_pending+
      #   * +:num_subscriptions_deleted+
      #   
      def to_h
        attributes = client.get_topic_attributes(:topic_arn => arn).attributes
        {
          :arn => arn,
          :name => name,
          :owner => attributes['Owner'],
          :display_name => attributes['DisplayName'] || name,
          :policy => parse_policy(attributes['Policy']),
          :num_subscriptions_confirmed => attributes['SubscriptionsConfirmed'].to_i,
          :num_subscriptions_pending => attributes['SubscriptionsPending'].to_i,
          :num_subscriptions_deleted => attributes['SubscriptionsDeleted'].to_i,
        }
      end

      # @return [Boolean] Returns true if compared to another {Topic}
      #   with the same ARN.
      def ==(other)
        other.kind_of?(Topic) and other.arn == arn
      end
      alias_method :eql?, :==

      # @private
      protected
      def parse_policy policy_json
        if policy_json
          policy = SNS::Policy.from_json(policy_json)
          policy.extend(PolicyProxy)
          policy.topic = self
          policy
        else
          nil
        end
      end

      # @private
      protected
      def set_attribute name, value
        client.send(:set_topic_attributes, {
          :topic_arn => arn,
          :attribute_name => name,
          :attribute_value => value,
        })
      end

      # @private
      module PolicyProxy
        attr_accessor :topic
        def change
          yield(self)
          topic.policy = self
        end
      end

      # @private
      protected
      def endpoint_opts(endpoint, opts = {})

        case
        when endpoint.is_a?(SQS::Queue)

          # auto add a policy to the queue to allow the topic
          # to send the queue messages
          unless opts[:update_policy] == false
            policy = endpoint.policy || SQS::Policy.new
            policy.allow(
              :principal => :any, 
              :actions => [:send_message], 
              :resources => [endpoint]
            ).where(:source_arn).is(arn)
            endpoint.policy = policy
          end
          
          { :protocol => 'sqs', :endpoint => endpoint.arn }

        when endpoint =~ /^arn:/
          raise ArgumentError, "expected a queue ARN" unless
            endpoint =~ /^arn:aws:sqs:/
          { :protocol => "sqs", :endpoint => endpoint }
        when endpoint.kind_of?(URI)
          { :protocol => endpoint.scheme,
            :endpoint => endpoint.to_s }
        when endpoint =~ /^(https?):/
          { :protocol => $1, :endpoint => endpoint }
        when endpoint.include?("@")
          { :protocol => opts[:json] ? "email-json" : "email",
            :endpoint => endpoint }
        else
          raise ArgumentError, "could not determine protocol for '#{endpoint}'"
        end
      end

    end
  end
end
