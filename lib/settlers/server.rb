require 'observer'

module Settlers
  class Server
    include Observable

    def initialize(name, port)
      @address = Address.new(name, '127.0.0.1', port)
    end

    def start
      Java.server.start(@address.port, 10, 'root', '')

      changed
      notify_observers @address

      sleep 5

      %w(Leonardo Humperdink Elwood).each do |name|
        Java.robot.start(@address.host, @address.port, name, '')
      end
    end
  end
end
