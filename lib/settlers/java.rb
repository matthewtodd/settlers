module Settlers
  class Java
    def self.server
      new('soc.server.SOCServer')
    end

    def self.client
      new('soc.client.SOCPlayerClient')
    end

    JAR = Settlers.datadir.join('jsettlers-1.1.09', 'JSettlers.jar')

    def initialize(class_name)
      @class_name = class_name
    end

    def run(*args)
      pid = quietly_fork(args)
      Process.waitpid(pid)
    end

    def start(*args)
      pid = quietly_fork(args)
      at_exit { Process.kill 'INT', pid }
    end

    private

    def quietly_fork(args)
      args.map! { |arg| arg.to_s }

      fork do
        STDOUT.reopen '/dev/null'
        STDERR.reopen '/dev/null'
        exec 'java', '-cp', JAR, @class_name, *args
      end
    end
  end
end
