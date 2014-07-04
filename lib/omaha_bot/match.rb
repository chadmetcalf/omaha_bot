module OmahaBot
  class Match
    include OmahaBot

    attr_accessor :round, :small_blind, :big_blind, :on_button, :max_win_pot,
                  :amount_to_call, :table

    def self.instance
      @instance ||= new
    end

    def initialize
      @table = []
    end

    def play
      logger.debug "Playing!"
      while STDIN.gets
        parser.hear($_)
      end
    end

    def table=(arg)
      @table = arg
    end

    def table
      @table
    end
  end
end
