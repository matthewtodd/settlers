module Settlers
  class Jar
    def initialize(path)
      @path = path
    end

    def running(class_name)
      JavaCommand.new(full_path, class_name)
    end

    private

    def full_path
      File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'resources', 'jsettlers-1.0.6', @path))
    end
  end
end
