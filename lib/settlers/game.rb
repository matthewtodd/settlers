module Settlers
  class Game
    def initialize(host='localhost', port=8880)
      @host, @port = host, port
      @runner = Runner.new
    end

    def play
      @runner.background server.command('soc.server.SOCServer', @port, 4, 'root', ''); sleep 5
      @runner.background server.command('soc.robot.SOCRobotClient', @host, @port, 'Leonardo', '')
      @runner.background server.command('soc.robot.SOCRobotClient', @host, @port, 'Humperdink', '')
      @runner.background server.command('soc.robot.SOCRobotClient', @host, @port, 'Elwood', '')
      @runner.foreground client.command('soc.client.SOCPlayerClient', @host, @port)
      @runner.clean_up
    end

    private

    def server
      Jar.new('JSettlersServer.jar')
    end

    def client
      Jar.new('JSettlers.jar')
    end
  end
end