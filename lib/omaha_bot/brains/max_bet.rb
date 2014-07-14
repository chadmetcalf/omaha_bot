module OmahaBot
  module Brain
    class MaxBet
      include Core
      include Brain

      def decide
        @decision = :bet
        @decision_amount = match.pot
      end

    end
  end
end
