module OmahaBot
  class Player
    include OmahaBot

    attr_accessor :stack, :hand

    def act
      logger.debug "Amount to call: #{match.amount_to_call}"
      if match.amount_to_call.to_i == 0
        check
        return
      end
      fold
    end

    def fold
      puts "fold 0"
    end

    def check
      puts "check 0"
    end

    def call(amount = 0)
      puts "call #{amount}"
    end

    def raise(amount = 0)
      puts "raise #{amount}"
    end

    def finish_game
      puts "Good Game"
      Kernel.exit!(true)
    end
  end
end
