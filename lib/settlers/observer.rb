module Settlers
  module Observer
    def update(*args)
      send(*args) if respond_to?(args.first)
    end
  end
end
