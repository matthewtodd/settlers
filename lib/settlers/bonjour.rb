require 'dnssd'
require 'observer'

module Settlers
  class Bonjour
    TYPE = '_settlers._tcp'

    include Observable

    def update(name, host, port)
      DNSSD.register(name, TYPE, nil, port)
    end

    def start
      puts 'Looking for servers nearby...'
      DNSSD.browse(TYPE) do |browse|
        DNSSD.resolve(browse) do |reply|
          DNSSD.getaddrinfo!(reply.target, DNSSD::Service::IPv4) do |info|
            changed
            notify_observers(reply.name, info.address, reply.port)
          end
        end
      end
    end

    def DNSSD.getaddrinfo!(*args, &block)
      run(DNSSD::Service.new, :getaddrinfo, *args, &block)
    end
  end
end
