require 'ipaddr'

module Settlers
  class Address < Struct.new(:name, :host, :port)
    include Comparable

    def self.from(reply, info)
      new reply.name, info.address, reply.port
    end

    def <=>(other)
      [name, ip, port] <=> [other.name, other.ip, other.port]
    end

    def ip
      IPAddr.new(host)
    end

    def to_s
      "#{name} (#{host}:#{port})"
    end
  end
end
