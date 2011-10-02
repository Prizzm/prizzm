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

require 'aws/lazy_error_classes'
require 'aws/simple_db/client/xml'

module AWS
  class SimpleDB

    # This module contains exception classes for each of the error
    # types that SimpleDB can return.  You can use these classes to
    # rescue specific errors, for example:
    #
    #  begin
    #    SimpleDB.new.domains.mydomain.
    #      items["foo"].attributes.set(:color => "red")
    #  rescue SimpleDB::Errors::NoSuchDomain => e
    #    SimpleDB.new.domians.create("mydomain")
    #    retry
    #  end
    #
    # Each exception has:
    #
    # * +code+: returns the error code as a string.
    # * +box_usage+: returns the box usage for the operation.
    #
    # All errors raised as a result of error responses from the
    # service are instances of either {ClientError} or {ServerError}.
    # @private
    module Errors
      BASE_ERROR_GRAMMAR = Client::XML::BaseError
      include LazyErrorClasses
    end

  end
end
