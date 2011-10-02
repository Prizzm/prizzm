class Voxel < Fog::Bin
  class << self

    def class_for(key)
      case key
      when :compute
        Fog::Compute::Voxel
      else
        raise ArgumentError, "Unrecognized service: #{key}"
      end
    end

    def [](service)
      @@connections ||= Hash.new do |hash, key|
        hash[key] = case key
        when :compute
          Formatador.display_line("[yellow][WARN] Voxel[:compute] is deprecated, use Compute[:voxel] instead[/]")
          Fog::Compute.new(:provider => 'Voxel')
        else
          raise ArgumentError, "Unrecognized service: #{key.inspect}"
        end
      end
      @@connections[service]
    end

    def services
      Fog::Voxel.services
    end

  end
end
