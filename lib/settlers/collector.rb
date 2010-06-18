require 'set'

module Settlers
  class Collector
    include Enumerable
    include Observer

    def initialize
      @addresses = Set.new
    end

    def server_exists_at(address)
      @addresses.add(address)
    end

    def each(&block)
      @addresses.sort.each(&block)
    end

    def size
      @addresses.size
    end
  end
end
