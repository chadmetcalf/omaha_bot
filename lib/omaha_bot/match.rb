module OmahaBot
  class Match
    include Core

    attr_accessor :round, :small_blind, :big_blind, :on_button, :max_win_pot,
                  :amount_to_call, :table, :pot

    def self.instance
      @instance ||= new
    end

    def initialize
      @table = []
      @pot   = 0
    end


    # The Parser setting the round is what triggers a player hand.
    def round=(number=1)
      @round = number.to_i
      play_hand
    end
    alias :hand_number :round

    def play_hand
      logger.info "Playing Hand #{hand_number}"
      @table = []
      @pot   = 0
      players.each {|p| p.start_hand}
    end

    def amount_to_call
      return nil if @amount_to_call.nil?
      @amount_to_call.to_i
    end

    def finish_hand
      players.each {|p| p.finish_hand}
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
      @pot = amount.to_i
    end

    def pot
      @pot
    end

    def player
      @player ||= setup_player
    end

    def opponent
      @opponent ||= Player.new(:opponent)
    end

    def players
      [player, opponent]
    end

    def setup_player
      Player.new(:call)

      # return Player.new(:compitition) if env.production?
      # return Player.new(:training) if defined?(TrainingPlayer)
      # GenePlayer.new
    end
  end
end
