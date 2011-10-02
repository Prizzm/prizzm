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

require 'aws/model'
require 'aws/s3/prefix_and_delimiter_collection'
require 'aws/s3/multipart_upload'
require 'aws/s3/s3_object'

module AWS
  class S3

    # Represents the uploads in progress for a bucket.
    #
    # @example Finding uploads by prefix
    #  bucket.multipart_uploads.with_prefix("photos/").
    #    map { |upload| upload.object.key }
    #  # => ["photos/1.jpg", "photos/2.jpg", ...]
    #
    # @example Browsing with a tree interface
    #  bucket.multipart_uploads.with_prefix("photos").as_tree.
    #    children.select(&:branch?).map(&:prefix)
    #  # => ["photos/2010", "photos/2011", ...]
    #
    # @see Tree
    class MultipartUploadCollection

      include Enumerable
      include Model
      include PrefixAndDelimiterCollection

      # @return [Bucket] The bucket in which the uploads are taking
      #   place.
      attr_reader :bucket

      # @private
      def initialize(bucket, opts = {})
        @bucket = bucket
        super
      end

      protected
      def each_member_in_page(page, &block)
        super
        page.uploads.each do |u|
          object = S3Object.new(bucket, u.key)
          upload = MultipartUpload.new(object, u.upload_id)
          yield(upload)
        end
      end

      protected
      def list_request(options)
        client.list_multipart_uploads(options)
      end

      protected
      def limit_param; :max_uploads; end

      protected
      def pagination_markers; super + [:upload_id_marker]; end

      protected
      def page_size(resp); super + resp.uploads.size; end

    end

  end
end
