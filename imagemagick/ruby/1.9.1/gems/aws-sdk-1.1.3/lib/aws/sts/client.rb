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

require 'aws/base_client'
require 'aws/configured_client_methods'
require 'aws/sts/request'
require 'aws/sts/client/xml'
require 'aws/sts/errors'

module AWS
  class STS

    # @private
    class Client < BaseClient

      include ConfiguredClientMethods

      API_VERSION = '2011-06-15'

      REGION_US_E1 = 'sts.amazonaws.com'

      REQUEST_CLASS = STS::Request

      configure_client

    end
  end
end
