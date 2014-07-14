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
    # Actions

    def post(amount)
      @stack -= amount
      match.pot += amount
    end

    def fold
      puts "fold 0"
    end

    def check
      puts "check 0"
    end

    def call
      return check unless match.amount_to_call
      @stack -= match.amount_to_call
      match.pot += match.amount_to_call
      puts "call #{match.amount_to_call}"
    end

    def bet(amount = 0)
      amount = amount.to_i
      return all_in if @stack <= amount
      #move amount
      #to the pot
      match.pot += amount
      #from the stack
      @stack -= amount
      puts "raise #{amount}"
    end

    def all_in
      #move stack
      #to the pot
      match.pot += @stack
      #from the stack
      @stack -= @stack

      puts "raise #{@stack}"
    end

    ##
    # the player starts a hand
    def start_hand
      @hand = Hand.new
      brain.start_hand(hand)
    end

    ##
    # The player acts
    def act
      return missing_brain! unless brain?
      brain.decide
      send(brain.decision)
    end

    ##
    # the player finishes the hand
    def finish_hand
    end

    def finish_game
      puts "Good Game"
      exit
    end
  end
end
