require 'set'

module Settlers
  class Collector
    include Enumerable

    def initialize
      @servers = Set.new
    end

    def update(name, host, port)
      @servers << Address.new(name, host, port)
    end

    def each(&block)
      @servers.sort.each(&block)
    end

    def size
      @servers.size
    end

    private

    class Address < Struct.new(:name, :host, :port)
      include Comparable

      def <=>(other)
        name <=> other.name
      end

      def to_s
        "#{name} (#{host}:#{port})"
      end
    end
  end
end
