module OmahaBot
  module Brain
    class MaxBet
      include Core
      include Brain

      def decide
        @decision = :bet
        @decisoun_amount = match.pot
      end

    end
  end
end
