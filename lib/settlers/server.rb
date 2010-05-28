require 'observer'

module Settlers
  class Server
    include Observable

    def initialize(port)
      @port = port
    end

    def start
      Java.server.start(@port, 10, 'root', '')

      changed
      notify_observers 'change me', '127.0.0.1', @port

      sleep 5

      %w(Leonardo Humperdink Elwood).each do |name|
        Java.robot.start('127.0.0.1', @port, name, '')
      end
    end
  end
end
