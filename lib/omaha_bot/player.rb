module OmahaBot
  module Player
    extend self

    include Core

    attr_accessor :stack, :hand

    def initialize
      @stack = 0
      @hand =  []
    end

    def act
      logger.debug "Amount to call: #{match.amount_to_call}"
      if match.amount_to_call.to_i == 0
        check
        return
      end

      case rand(1..10)
      when 1..6
        check
      when 7..9
        call rand(@stack)
      when 10
        fold
      end
    end

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

    def call(amount = 0)
      @stack -= amount
      match.pot += amount
      puts "call #{amount}"
    end

    def raise(amount = 0)
      @stack -= amount
      match.pot += amount
      puts "raise #{amount}"
    end

    def all_in
      match.pot += @stack
      puts "raise #{@stack}"
    end

    def start_round
    end

    def finish_round
      @hand = []
    end

    def win_round
      @stack += match.pot
    end

    def finish_game
      puts "Good Game"
      Kernel.exit!(true)
    end
  end
end
