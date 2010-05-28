module Settlers
  class Java
    def self.server
      new('JSettlers.jar', 'soc.server.SOCServer')
    end

    def self.robot
      new('JSettlers.jar', 'soc.robot.SOCRobotClient')
    end

    def self.client
      new('JSettlers.jar', 'soc.client.SOCPlayerClient')
    end

    PATH = Settlers.datadir.join('jsettlers-1.1.09')

    def initialize(jar_name, class_name)
      @jar_name   = jar_name
      @class_name = class_name
    end

    def run(*args)
      system *command(args)
    end

    def start(*args)
      pid = fork { exec *command(args) }
      at_exit { Process.kill 'INT', pid }
    end

    private

    def command(args)
      ['java', '-cp', PATH.join(@jar_name), @class_name].concat(args.map { |arg| arg.to_s })
    end
  end
end
