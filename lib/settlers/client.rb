module Settlers
  class Client
    def initialize(host, port)
      @host = host
      @port = port
    end

    def start
      Java.client.run(@host, @port)
    end
  end
end
