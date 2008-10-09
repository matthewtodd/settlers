module Settlers
  class Runner
    def initialize
      @pids = []
    end

    def background(command)
      @pids.unshift fork { exec *ensure_strings(command) }
    end

    def foreground(command)
      system *ensure_strings(command)
    end

    def clean_up
      Process.kill 'INT', *@pids
    end

    private

    def ensure_strings(command)
      command.map { |arg| arg.to_s }
    end
  end
end
