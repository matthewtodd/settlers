require 'highline'

module Settlers
  class UI
    def initialize
      @console = HighLine.new
    end

    def choose_server(list)
      address = case list.size
                when 1
                  list.first
                else
                  choose_from_many(list)
                end

      yield address.host, address.port
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
