module Settlers
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
