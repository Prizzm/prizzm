class DNSimple < Fog::Bin
  class << self

    def class_for(key)
      case key
      when :dns
        Fog::DNS::DNSimple
      else
        raise ArgumentError, "Unrecognized service: #{key}"
      end
    end

    def [](service)
      @@connections ||= Hash.new do |hash, key|
        hash[key] = case key
        when :dns
          Formatador.display_line("[yellow][WARN] DNSimple[:dns] is deprecated, use Storage[:dnsimple] instead[/]")
          Fog::DNS.new(:provider => 'DNSimple')
        else
          raise ArgumentError, "Unrecognized service: #{key.inspect}"
        end
      end
      @@connections[service]
    end

    def services
      Fog::DNSimple.services
    end

  end
end
