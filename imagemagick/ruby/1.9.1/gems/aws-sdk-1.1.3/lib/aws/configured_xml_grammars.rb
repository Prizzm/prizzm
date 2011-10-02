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

require 'aws/configured_grammars'
require 'aws/xml_grammar'

module AWS

  # @private
  module ConfiguredXmlGrammars

    # @private
    module ClassMethods

      include ConfiguredGrammars::ClassMethods

      def base_grammar
        if const_defined?(:BaseResponse)
          const_get(:BaseResponse)
        else
          XmlGrammar
        end
      end

      def input_or_output
        :output
      end

    end

    def self.included(mod)
      mod.extend(ClassMethods)
    end

  end

end
