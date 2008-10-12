module Settlers
  class Jar
    def initialize(path)
      @path = path
    end

    def run(class_name)
      JarCommand.new(full_path, class_name)
    end

    private

    def full_path
      File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'resources', 'jsettlers-1.0.6', @path))
    end

    class JarCommand < Struct.new(:class_path, :class_name)
      def with(*args)
        "java -cp #{class_path} #{class_name} #{args.join(' ')}"
      end
    end
  end
end
