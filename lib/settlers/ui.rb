require 'highline'

module Settlers
  class UI
    def initialize
      @console = HighLine.new
    end

    def choose_server(list)
      yield case list.size
            when 1
              list.first
            else
              choose_from_many(list)
            end
    end

    class Verbose < UI
      def choose_server(list)
        yield choose_from_many(list)
      end
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
