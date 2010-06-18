module Settlers
  class Address < Struct.new(:name, :host, :port)
    include Comparable

    def self.from(reply, info)
      new reply.name, info.address, reply.port
    end

    def <=>(other)
      name <=> other.name
    end

    def to_s
      "#{name} (#{host}:#{port})"
    end
  end
end
