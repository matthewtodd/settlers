module Settlers
  class Game
    def initialize(port=8880, server_delay=2)
      @host, @port, @server_delay, @runner = 'localhost', port, server_delay, Runner.new
    end

    def play
      @runner.background server.with(@port, 4, 'root', "''"); sleep @server_delay.to_i
      @runner.background robot.with(@host, @port, 'Leonardo', "''")
      @runner.background robot.with(@host, @port, 'Humperdink', "''")
      @runner.background robot.with(@host, @port, 'Elwood', "''")
      @runner.foreground client.with(@host, @port)
    end

    private

    def server
      Jar.new('JSettlersServer.jar').run('soc.server.SOCServer')
    end

    def robot
      Jar.new('JSettlersServer.jar').run('soc.robot.SOCRobotClient')
    end

    def client
      Jar.new('JSettlers.jar').run('soc.client.SOCPlayerClient')
    end
  end
end