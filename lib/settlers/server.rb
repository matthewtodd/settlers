require 'observer'

module Settlers
  class Server
    include Observable

    def initialize(port)
      @name    = "#{`whoami`.chomp}@#{`hostname`.chomp}"
      @address = '127.0.0.1'
      @port    = port
    end

    def start
      Java.server.start(@port, 10, 'root', '')

      changed
      notify_observers @name, @address, @port

      sleep 5

      %w(Leonardo Humperdink Elwood).each do |name|
        Java.robot.start(@address, @port, name, '')
      end
    end
  end
end
