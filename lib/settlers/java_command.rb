module Settlers
  class JavaCommand
    def initialize(class_path, class_name)
      @class_path, @class_name = class_path, class_name
    end

    def with(*args)
      "java -cp #{@class_path} #{@class_name} #{args.join(' ')}"
    end
  end
end
