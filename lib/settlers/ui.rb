require 'highline'

module Settlers
  class UI
    def initialize
      @console = HighLine.new
    end

    def choose_server(list)
      yield case list.size
            when 0
              abort 'No servers to choose from.'
            when 1
              list.first
            else
              choose_from_many(list)
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
