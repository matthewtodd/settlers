require 'optparse'
require 'set'
require 'shellwords'

require 'dnssd'
require 'highline/import'

module Settlers
  class Application
    attr_accessor :server, :client, :style

    def initialize(*args)
      self.server = Server.new
      self.client = Client.new
      self.style  = StandaloneGame
      parse_options(args)
    end

    def run
      style.new(self).run
    end

    def start_server
      server.start
    end

    def start_client(server)
      client.start(server)
    end

    def find_server
      choose(*available_servers)
    end

    private

    def parse_options(args)
      # TODO it would be nice to provide a quick tabtab definition here.
      OptionParser.new do |opts|
        opts.on('-c', '--client') { self.style = BonjourClientGame }
        opts.parse!(args)
      end
    end

    class StandaloneGame < Struct.new(:app)
      def run
        app.start_server
        app.start_client(app.server)
      end
    end

    class BonjourClientGame < Struct.new(:app)
      def run
        app.start_client(app.find_server)
      end
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

    class Server
      # Maybe we can change these to attr_writer as we'd like to make them command-line configurable.
      attr_reader :name, :host, :port, :startup_delay, :maximum_connections, :username, :password, :robot_names

      def initialize
        @name = "#{`hostname -s`.chomp}-#{`whoami`.chomp}"
        @host = 'localhost'
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
        sleep(startup_delay)
        start_robots
      end

      private

      def announce
        # Maybe it would be nice to include a TextRecord here providing something of a description?
        DNSSD.register(name, '_settlers._tcp', 'local', port) do |rr|
          puts "Announcing settlers server available on port #{port}."
        end
      end

      def serve
        # TODO move the Shellwords.escape call inside of JavaCommand.start
        Jar.new('JSettlers.jar').running('soc.server.SOCServer').start(port, maximum_connections, username, Shellwords.escape(password))
      end

      def start_robots
        robot_names.each do |name|
          # TODO move the Shellwords.escape call inside of JavaCommand.start
          Jar.new('JSettlers.jar').running('soc.robot.SOCRobotClient').start(host, port, name, Shellwords.escape(password))
        end
      end
    end

    class RemoteServer < Struct.new(:name, :host, :port)
      def to_s
        "#{name} (#{host}:#{port})"
      end
    end

    class Client
      def start(server)
        Jar.new('JSettlers.jar').running('soc.client.SOCPlayerClient').run(server.host, server.port)
      end
    end
  end
end
