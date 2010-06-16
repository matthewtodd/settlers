module Settlers
  class Application
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

      server = Server.new(PORT)
      server.add_observer(@bonjour)
      server.add_observer(@collector)
      server.start

      @ui.choose_server(@collector) do |host, port|
        Client.new(host, port).start
      end
    end

  end
end
