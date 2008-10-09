module Settlers
  class Jar
    def initialize(path)
      @path = path
    end

    def command(*args)
      ['java', '-cp', full_path] + args.map { |arg| arg.to_s }
    end

    private

    def full_path
      File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'resources', 'jsettlers-1.0.6', @path))
    end
  end
end
