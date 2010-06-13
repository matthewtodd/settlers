module Settlers
  class Java
    def self.server
      new('soc.server.SOCServer')
    end

    def self.robot
      new('soc.robot.SOCRobotClient')
    end

    def self.client
      new('soc.client.SOCPlayerClient')
    end

    JAR = Settlers.datadir.join('jsettlers-1.1.09', 'JSettlers.jar')

    def initialize(class_name)
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
      ['java', '-cp', JAR, @class_name].concat(args.map { |arg| arg.to_s })
    end
  end
end
