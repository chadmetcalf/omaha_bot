module OmahaBot
  class NoBrainError < ::NoMethodError; end

  module Brain
    class BadDecisionError < ::NoMethodError; end

    module ClassMethods
      def self.instance(brain_type_arg)
        brain_type = brain_type_arg
        unless REGISTERED_BRAINS.include?(brain_type.snakecaserize.to_sym)
          raise OmahaBot::NoBrainError.new "#{brain_type} is not a type of brain."
        end
        require_relative "brains/#{brain_type}"
        #if instance variable of brain type exists, return that
        brain = if instance_variable_defined?("@#{brain_type}")
          instance_variable_get("@#{brain_type}")
        else
          brain = OmahaBot::Brain.const_get(brain_type.constantize).new

          instance_variable_set("@#{brain_type}", brain)

          brain
        end

        raise NoBrainError.new "No Brain instance for #{brain_type}!" unless brain
        brain
      end
    end


    ##
    # Core Player setup

    extend self
    include Core

    REGISTERED_BRAINS = [:compitition, :training, :opponent,
                         :all_in, :call, :max_bet]

    attr_accessor :brain_type

    def initialize
    end

    ##
    # Set context for decision
    def start_hand(hand)
      @hand = hand
      @decision = nil
      @table = match.table
    end

    def decide
      raise BadDecisionError.new "No decision is being made by #{self.brain_type} is not a possible decision"
    end

    def decision
      decide if @decision.nil?
      unless possible_decisions.include? @decision
        raise BadDecisionError.new "#{@decision} is not a possible decision"
      end
      return decision_args
    end

    def possible_decisions
      [:fold, :check, :call, :bet, :all_in]
    end

    def decision_args
      return [@decision, @decision_amount] if @decision_amount
      @decision
    end

    ##
    # Calculations

    def amount_to_call
      match.amount_to_call.to_i
    end

    def pot_odds
      @pot_odds
    end

    def implied_pot_odds
      @implied_pot_odds
    end

    def equity
      @equity
    end

    def calculate_pot_odds
      @pot_odds = ( amount_to_call / match.pot ) if !match.pot.zero?
      @implied_pot_odds = 0
      @equity = probability_of_winning * (match.pot + amount_to_call)
    end

    def probability_of_winning
      0.25
    end
  end
end
