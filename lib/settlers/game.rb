module Settlers
  class Game
    def initialize(port=8880)
      @host, @port, @runner = 'localhost', port, Runner.new
    end

    def play
      @runner.background server.with(@port, 4, 'root', "''"); sleep 2
      @runner.background robot.with(@host, @port, 'Leonardo', "''")
      @runner.background robot.with(@host, @port, 'Humperdink', "''")
      @runner.background robot.with(@host, @port, 'Elwood', "''")
      @runner.foreground client.with(@host, @port)
    end

    private

    def server
      Jar.new('JSettlersServer.jar').running('soc.server.SOCServer')
    end

    def robot
      Jar.new('JSettlersServer.jar').running('soc.robot.SOCRobotClient')
    end

    def client
      Jar.new('JSettlers.jar').running('soc.client.SOCPlayerClient')
    end
  end
end