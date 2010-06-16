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
      server.add_observer(@collection)
      server.add_observer(discovery)
      server.start

      @ui.choose_server(@collection) do |host, port|
        Client.new(host, port).start
      end
    end

    class UserInteraction
      def initialize
        @console = HighLine.new
      end

      def choose_server(list)
        address = case list.size
                  when 1
                    list.first
                  else
                    choose_from_many(list)
                  end

        yield address.host, address.port
      end

      private

      def choose_from_many(list)
        begin
          @console.choose(*list)
        rescue Interrupt
          abort "\nGoodbye."
        end
      end
    end
  end
end
