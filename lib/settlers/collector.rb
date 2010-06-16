require 'set'

module Settlers
  class Collector
    include Enumerable

    def initialize
      @addresses = Set.new
    end

    def update(address)
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
