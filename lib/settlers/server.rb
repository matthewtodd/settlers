require 'etc'
require 'observer'

module Settlers
  class Server
    include Observable

    def initialize(port)
      @address = Address.new(name, '127.0.0.1', port)
    end

    def start
      Java.server.start(@address.port, 10, 'root', '')
      changed
      notify_observers :server_exists_at, @address
    end

    private

    def name
      login = Etc.getlogin
      name  = Etc.getpwnam(login).gecos
      "#{name}'s Settlers Server"
    end
  end
end
