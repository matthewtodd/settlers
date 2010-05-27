require 'dnssd'
require 'highline/import'
require 'optparse'
require 'set'

module Settlers
  class Application
    def initialize(*args)
      @server = Server.new
      @client = Client.new
      @style  = StandaloneGame

      @options = OptionParser.new do |opts|
        opts.version = Settlers::VERSION
        opts.on('-c', '--client') { @style = BonjourClientGame }
      end
    end

    def run(args)
      @options.parse(args)
      @style.new(@server, @client).run
    end

    private

    class StandaloneGame < Struct.new(:server, :client)
      def run
        server.start
        client.start(server)
      end
    end

    class BonjourClientGame < Struct.new(:server, :client)
      def run
        client.start(find_server)
      end

      private

      def find_server
        choose(*available_servers)
      end

      def available_servers(timeout = 3)
        servers = Set.new

        dns = DNSSD.browse('_settlers._tcp') do |reply|
          DNSSD.resolve(reply.name, reply.type, reply.domain) do |resolve_reply|
            servers << RemoteServer.new(reply.name, resolve_reply.target, resolve_reply.port)
          end
        end

        puts 'Looking for settlers servers nearby...'
        sleep timeout
        dns.stop

        return servers
      end

      class RemoteServer < Struct.new(:name, :host, :port)
        def to_s
          "#{name} (#{host}:#{port})"
        end
      end
    end

    class Server
      attr_reader :host, :port

      def initialize
        @name = "#{`hostname -s`.chomp}-#{`whoami`.chomp}"
        @host = '127.0.0.1'
        @port = 8880
        @startup_delay = 4
        @maximum_connections = 12
        @username = 'root'
        @password = ''
        @robot_names = %w(Leonardo Humperdink Elwood)
      end

      def start
        announce
        serve
        sleep(@startup_delay)
        start_robots
      end

      private

      def announce
        # Maybe it would be nice to include a TextRecord here providing something of a description?
        DNSSD.register(@name, '_settlers._tcp', 'local', @port) do |rr|
          puts "Announcing settlers server available on port #{@port}."
        end
      end

      def serve
        Jar.new('JSettlers.jar').running('soc.server.SOCServer').start(@port, @maximum_connections, @username, @password)
      end

      def start_robots
        @robot_names.each do |name|
          Jar.new('JSettlers.jar').running('soc.robot.SOCRobotClient').start(@host, @port, name, @password)
        end
      end
    end

    class Client
      def start(server)
        Jar.new('JSettlers.jar').running('soc.client.SOCPlayerClient').run(server.host, server.port)
      end
    end
  end
end
