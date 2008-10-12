module Settlers
  class Runner
    def background(command)
      pid = fork { exec command }
      at_exit { Process.kill 'INT', pid }
    end

    def foreground(command)
      system command
    end
  end
end
