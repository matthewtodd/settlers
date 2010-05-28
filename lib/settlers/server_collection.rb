require 'set'

module Settlers
  class ServerCollection
    include Enumerable

    def initialize
      @servers = Set.new
    end

    def update(name, host, port)
      @servers << Address.new(name, host, port)
    end

    def each(&block)
      @servers.each(&block)
    end

    private

    class Address < Struct.new(:name, :host, :port)
      def to_s
        "#{name} (#{host}:#{port})"
      end
    end
  end
end
