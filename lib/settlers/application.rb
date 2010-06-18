module Settlers
  class Application
    DEFAULT_PORT = 7777

    def initialize
      @collector = Collector.new
      @ui        = UI.new

      @defaults = %w(--server)

      @options = OptionParser.new do |opts|
        opts.banner  = "Usage: #{File.basename($0)} [--client]"
        opts.separator ''
        opts.version = Settlers::VERSION

        opts.on('-c', '--client', 'Discover and connect to a server.') do
          @announcer  = NullObject.new
          @discoverer = Bonjour.new
          @server     = NullObject.new
        end

        opts.on('-s', '--server[=PORT]', Integer, 'Launch, announce, and connect to a server.', "  (PORT defaults to #{DEFAULT_PORT}.)") do |port|
          @announcer  = Bonjour.new
          @discoverer = NullObject.new
          @server     = Server.new(port || DEFAULT_PORT)
        end

        opts.separator ''
        opts.separator 'Defaults:'
        opts.separator "#{opts.summary_indent}#{@defaults.join(' ')}"
      end
    end

    def run(args)
      @options.parse!(@defaults.dup.concat(args))

      @server.add_observer(@announcer)
      @server.add_observer(@collector)
      @server.start

      @discoverer.add_observer(@collector)
      @discoverer.start

      @ui.choose_server(@collector) do |address|
        Client.new(address).start
      end
    end

    private

    class NullObject
      def add_observer(observer)
      end

      def update(*args)
      end

      def start
      end
    end

  end
end
