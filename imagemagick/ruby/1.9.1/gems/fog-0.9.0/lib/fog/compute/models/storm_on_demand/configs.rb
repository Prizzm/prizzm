require 'fog/core/collection'
require 'fog/compute/models/storm_on_demand/config'

module Fog
  module Compute
    class StormOnDemand

      class Configs < Fog::Collection

        model Fog::Compute::StormOnDemand::Config

        def all
          data = connection.list_configs.body['configs']
          load(data)
        end


      end

    end
  end
end
