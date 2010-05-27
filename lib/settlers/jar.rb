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
      Settlers.datadir.join('jsettlers-1.0.6', @path)
    end
  end
end
