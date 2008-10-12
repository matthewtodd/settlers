module Settlers
  class Game
    DEFAULT_PORT = 8880
    MAXIMUM_SERVER_CONNECTIONS = 4
    SERVER_STARTUP_DELAY = 2
    NO_PASSWORD = "''"

    def initialize(port=DEFAULT_PORT)
      @host, @port = 'localhost', port
    end

    def play
      server.start(@port, MAXIMUM_SERVER_CONNECTIONS, 'root', NO_PASSWORD); sleep SERVER_STARTUP_DELAY
      robot.start(@host, @port, 'Leonardo', NO_PASSWORD)
      robot.start(@host, @port, 'Humperdink', NO_PASSWORD)
      robot.start(@host, @port, 'Elwood', NO_PASSWORD)
      human.run(@host, @port)
    end

    private

    def server
      Jar.new('JSettlersServer.jar').running('soc.server.SOCServer')
    end

    def robot
      Jar.new('JSettlersServer.jar').running('soc.robot.SOCRobotClient')
    end

    def human
      Jar.new('JSettlers.jar').running('soc.client.SOCPlayerClient')
    end
  end
end