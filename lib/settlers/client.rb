module Settlers
  class Client
    def initialize(address)
      @address = address
    end

    def start
      Java.client.run(@address.host, @address.port)
    end
  end
end
