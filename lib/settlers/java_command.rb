module Settlers
  class JavaCommand
    def initialize(class_path, class_name)
      @class_path, @class_name = class_path, class_name
    end

    def run(*args)
      system command(args)
    end

    def start(*args)
      pid = fork { exec command(args) }
      at_exit { Process.kill 'INT', pid }
    end

    private

    def command(args)
      "java -cp #{@class_path} #{@class_name} #{args.join(' ')}"
    end
  end
end
