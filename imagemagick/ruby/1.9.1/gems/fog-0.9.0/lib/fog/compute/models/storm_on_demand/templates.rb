require 'fog/core/collection'
require 'fog/compute/models/storm_on_demand/template'

module Fog
  module Compute
    class StormOnDemand

      class Templates < Fog::Collection

        model Fog::Compute::StormOnDemand::Template

        def all
          data = connection.list_templates.body['templates']
          load(data)
        end

      end

    end
  end
end
