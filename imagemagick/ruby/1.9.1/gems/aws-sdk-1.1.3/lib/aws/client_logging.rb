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

  # @private
  module ClientLogging

    MAX_STRING_LENGTH = 50

    def log_client_request(name, options)
      response = nil
      time = Benchmark.measure do
        response = yield
      end

      if options[:async]
        response.on_complete do
          log_client_request_on_success(name, options, response, time)
        end
      else
        log_client_request_on_success(name, options, response, time)
      end
      response
    end

    # Summarizes long strings and adds file size information
    # @private
    def sanitize_options(options)
      sanitize_hash(options)
    end

    protected
    def log severity, message
      config.logger.send(severity, message + "\n") if config.logger
    end

    protected
    def log_client_request_on_success(method_name, options, response, time)
      status = response.http_response.status
      service = self.class.service_name

      pattern = "[AWS %s %s %.06f] %s(%s)"
      parts = [service, status, time.real, method_name, sanitize_options(options)]
      severity = :info

      if response.error
        pattern += " %s: %s"
        parts << response.error.class
        parts << response.error.message
        severity = :error
      end

      if response.cached
        pattern << " [CACHED]"
      end

      log(severity, pattern % parts)
    end

    protected
    def sanitize_value(value)
      case value
      when Hash
        '{' + sanitize_hash(value) + '}'
      when Array
        sanitize_array(value)
      when File
        sanitize_file(value)
      when String
        sanitize_string(value)
      else
        value.inspect
      end
    end

    protected
    def sanitize_string str
      summary = summarize_string(str)
      inspected = str.inspect
      if inspected.size > summary.size
        summary
      else
        inspected
      end
    end

    protected
    def summarize_string str
      "#<String #{str[0,6].inspect} ... #{str[-6,6].inspect} (#{str.size} characters)>"
    end

    protected
    def sanitize_file file
      "#<File:#{file.path} (#{File.size(file.path)} bytes)>"
    end

    protected
    def sanitize_array array
      "[" + array.map { |v| sanitize_value(v) }.join(",") + "]"
    end

    protected
    def sanitize_hash hash
      hash.map do |k,v|
        "#{sanitize_value(k)}=>#{sanitize_value(v)}"
      end.sort.join(",")
    end

  end

end
