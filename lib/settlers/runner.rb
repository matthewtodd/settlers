module Settlers
  class Runner
    def initialize
      @pids = []
    end

    def background(command)
      @pids.unshift fork { exec command }
    end

    def foreground(command)
      system command
    end

    def clean_up
      Process.kill 'INT', *@pids
    end
  end
end
