require 'dnssd'
require 'observer'

module Settlers
  class Bonjour
    TYPE = '_settlers._tcp'

    include Observable
    include Observer

    # To confirm registration is working, run `mDNS -B _settlers._tcp`.
    def server_exists_at(address)
      DNSSD.register!(address.name, TYPE, nil, address.port)
    end

    def start(timeout=5)
      puts "Looking for servers for up to #{timeout} seconds..."

      DNSSD.browse(TYPE) do |browse|
        DNSSD.resolve(browse) do |reply|
          DNSSD.getaddrinfo!(reply.target, DNSSD::Service::IPv4) do |info|
            changed
            notify_observers :server_exists_at, Address.from(reply, info)
          end
        end
      end

      sleep timeout
    end

    def DNSSD.getaddrinfo!(*args, &block)
      run(DNSSD::Service.new, :getaddrinfo, *args, &block)
    end
  end
end
