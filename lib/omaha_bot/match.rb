module OmahaBot
  class Match
    include OmahaBot

    attr_accessor :round, :small_blind, :big_blind, :on_button, :max_win_pot,
                  :amount_to_call, :table, :pot

    def self.instance
      @instance ||= new
    end

    def initialize
      @table = []
      @pot   = 0

      start_round
    end

    def round=(number=1)
      @round = number
      start_round
    end

    def start_round
      players.each {|p| p.start_round}
      logger.info "Starting Round #{round}"
    end

    def finish_round
      players.each {|p| p.finish_round}
      @table = []
      @pot   = 0
    end

    def play
      logger.debug "Playing!"
      while STDIN.gets
        parser.hear($_)
      end
    end

    def table=(array_of_cards)
      @table = array_of_cards
    end

    def table
      @table
    end

    def pot=(amount)
      @pot = amount
    end

    def pot
      @pot
    end

  end
end
