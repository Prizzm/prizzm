# encoding: BINARY

module EventMachine
  module WebSocket
    module MessageProcessor03
      def message(message_type, extension_data, application_data)
        case message_type
        when :close
          if @state == :closing
            # TODO: Check that message body matches sent data
            # We can close connection immediately since there is no more data
            # is allowed to be sent or received on this connection
            @connection.close_connection
            @state = :closed
          else
            # Acknowlege close
            # The connection is considered closed
            send_frame(:close, application_data)
            @state = :closed
            @connection.close_connection_after_writing
          end
        when :ping
          # Pong back the same data
          send_frame(:pong, application_data)
        when :pong
          # TODO: Do something. Complete a deferrable established by a ping?
        when :text, :binary
          @connection.trigger_on_message(application_data)
        end
      end
    end
  end
end
