module Fog
  module Compute
    class Brightbox
      class Real

        def add_listeners_load_balancer(identifier, options = {})
          return nil if identifier.nil? || identifier == ""
          request(
            :expects  => [202],
            :method   => 'POST',
            :path     => "/1.0/load_balancers/#{identifier}/add_listeners",
            :headers  => {"Content-Type" => "application/json"},
            :body     => options.to_json
          )
        end

      end
    end
  end
end