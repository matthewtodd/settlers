module Settlers
  class Application
    NAME = "#{`whoami`.chomp}@#{`hostname`.chomp}"
    PORT = 8880

    def initialize
      @bonjour   = Bonjour.new
      @collector = Collector.new
      @ui        = UI.new

      @options = OptionParser.new do |opts|
        opts.version = Settlers::VERSION
      end
    end

    def run(args)
      @options.parse(args)
      @bonjour.add_observer(@collector)
      @bonjour.start

      server = Server.new(NAME, PORT)
      server.add_observer(@bonjour)
      server.add_observer(@collector)
      server.start

      @ui.choose_server(@collector) do |address|
        Client.new(address).start
      end
    end

  end
end
