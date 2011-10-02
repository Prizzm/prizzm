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

module AWS

  # Mixin that provides a generic callback facility for asynchronous
  # tasks that can either succeed or fail.
  # @private
  module AsyncHandle

    # Called to signal success and fire off the success and complete callbacks.
    def signal_success
      __send_signal(:success)
    end

    # Called to signal failure and fire off the failure and complete callbacks.
    def signal_failure
      __send_signal(:failure)
    end

    # Registers a callback to be called on successful completion of
    # the task.
    #
    #  handle.on_success { puts "It worked!" }
    #
    # If this is called when the task has already completed
    # successfully, it will call the callback immediately.
    def on_success(&blk)
      if @_async_status == :success
        blk.call
      else
        (@_async_callbacks ||= []) << { :success => blk }
      end
    end

    # Registers a callback to be called when the task fails.
    #
    #  handle.on_failure { puts "It didn't work!" }
    #
    # If this is called when the task has already failed, it will
    # call the callback immediately.
    def on_failure(&blk)
      if @_async_status == :failure
        blk.call
      else
        (@_async_callbacks ||= []) << { :failure => blk }
      end
    end

    # Registers a callback to be called when the task is complete,
    # regardless of its status.  Yields the status to the block.
    #
    #  handle.on_complete do |status|
    #    puts "It #{status == :success ? 'did' : 'did not'} work!"
    #  end
    #
    # If this is called when the task has already completed, it will
    # call the callback immediately.
    def on_complete(&blk)
      if !@_async_status.nil?
        blk.call(@_async_status)
      else
        (@_async_callbacks ||= []) << {
          :failure => lambda { blk.call(:failure) },
          :success => lambda { blk.call(:success) }
        }
      end
    end

    private
    def __send_signal(kind)
      @_async_status = kind
      @_async_callbacks.map do |cb|
        cb[kind]
      end.compact.each { |blk| blk.call } if @_async_callbacks
    end

  end

end
