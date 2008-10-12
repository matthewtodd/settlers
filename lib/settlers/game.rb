module Settlers
  class Game
    DEFAULT_PORT = 8880
    MAXIMUM_SERVER_CONNECTIONS = 4
    SERVER_STARTUP_DELAY = 2

    def initialize(port=DEFAULT_PORT)
      @host, @port, @runner = 'localhost', port, Runner.new
    end

    def play
      @runner.background server.with(@port, MAXIMUM_SERVER_CONNECTIONS, 'root', "''"); sleep SERVER_STARTUP_DELAY
      @runner.background robot.with(@host, @port, 'Leonardo', "''")
      @runner.background robot.with(@host, @port, 'Humperdink', "''")
      @runner.background robot.with(@host, @port, 'Elwood', "''")
      @runner.foreground human.with(@host, @port)
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