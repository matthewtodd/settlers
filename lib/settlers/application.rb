require 'highline'

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

      discovery = Discovery.new
      discovery.add_observer(@collection)
      discovery.start

      server = Server.new(@port)
      server.add_observer(discovery)
      server.start

      @ui.choose_server(@collection) do |host, port|
        client = Client.new(host, port)
        client.start
      end
    end

    class UserInteraction
      def initialize
        @console = HighLine.new
      end

      def choose_server(list)
        address = @console.choose(*list)
        yield address.host, address.port
      end
    end
  end
end
