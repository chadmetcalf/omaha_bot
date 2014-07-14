require_relative 'brain'
require_relative 'hand'

module OmahaBot
  class Player
    include Core

    attr_accessor :stack, :hand, :brain

    def initialize(brain_type = :opponent)
      @brain = brain(brain_type)
      return missing_brain! unless brain?
      @stack = settings.starting_stack.to_i
    end

    def brain?
      !@brain.nil?
    end

    def brain(brain_type = nil)
      @brain ||= initalize_brain(brain_type)
    end

    def initalize_brain(brain_type)
      Brain::ClassMethods.instance(brain_type)
    end

    def missing_brain!
      raise NoBrainError.new "This player has no brain!"
    end

    ##
    # ACTION METHODS
    def fold
      puts "fold 0"
    end

    def check
      puts "check 0"
    end

    def call
      return check unless match.amount_to_call
      puts "call #{match.amount_to_call}"
    end

    def bet(amount)
      return all_in if @stack <= amount
      puts "raise #{amount}"
    end

    def all_in
      puts "raise #{@stack}"
    end

    ##
    # ACCOUNTING METHOD
    def push_chips(amount)
      #move amount
      #to the pot
      match.pot += amount
      #from the stack
      @stack -= amount
    end


    ##
    # the player starts a hand
    def start_hand
      @hand = Hand.new
      brain.start_hand(hand)
    end

    ##
    # The player looks at hole cards and starts thinking
    def hole_cards=(card_array)
      @hand.hole_cards = card_array
      decide
      @hand.hole_cards
    end

    ##
    # Evaluate the current situation and decide what action to take
    def decide
      brain.decide
    end

    ##
    # The player acts
    def act
      return missing_brain! unless brain?
      decision = brain.decision
      send(*decision)
      logger.info "Bot decided to #{decision.join(" ")}"
      0
    end

    ##
    # The player wins this hand
    def win_hand
      #move amount
      #to the stack
      @stack += match.pot
      #from the pot
      match.pot = 0
    end

    ##
    # The player finishes the hand
    def finish_hand
    end

    def finish_game
      puts "Good Game"
      exit
    end
  end
end
