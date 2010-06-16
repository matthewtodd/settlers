module Settlers
  class Application
    def initialize
      @ui         = UserInteraction.new
      @collection = ServerCollection.new
      @port       = 8880

      @options = OptionParser.new do |opts|
        opts.version = Settlers::VERSION
      end
    end

    def run(args)
      @options.parse(args)

      bonjour = Bonjour.new
      bonjour.add_observer(@collection)
      bonjour.start

      server = Server.new(@port)
      server.add_observer(@collection)
      server.add_observer(bonjour)
      server.start

      @ui.choose_server(@collection) do |host, port|
        Client.new(host, port).start
      end
    end

  end
end
