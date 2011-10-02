module FriendlyId

  module ActiveRecordAdapter

    include FriendlyId::Base

    def has_friendly_id(method, options = {})

      class_attribute :friendly_id_config
      self.friendly_id_config = Configuration.new(self, method, options)

      if friendly_id_config.use_slug?
        include SluggedModel
      else
        include SimpleModel
      end
    end

    private

    # Prevent the cached_slug column from being accidentally or maliciously
    # overwritten. Note that +attr_protected+ is used to protect the cached_slug
    # column, unless you have already invoked +attr_accessible+. So if you
    # wish to use +attr_accessible+, you must invoke it BEFORE you invoke
    # {#has_friendly_id} in your class.
    def protect_friendly_id_attributes
      # only protect the column if the class is not already using attr_accessible
      unless accessible_attributes.present?
        if friendly_id_config.custom_cache_column?
          attr_protected friendly_id_config.cache_column
        end
        attr_protected :cached_slug
      end
    end

  end
end

require "friendly_id/active_record_adapter/relation"
require "friendly_id/active_record_adapter/configuration"
require "friendly_id/active_record_adapter/simple_model"
require "friendly_id/active_record_adapter/slugged_model"
require "friendly_id/active_record_adapter/slug"
require "friendly_id/active_record_adapter/tasks"

module ActiveRecord
  class Base
    extend FriendlyId::ActiveRecordAdapter
  end

  class Relation
    alias find_one_without_friendly  find_one
    alias find_some_without_friendly find_some
    include FriendlyId::ActiveRecordAdapter::Relation
  end
end
