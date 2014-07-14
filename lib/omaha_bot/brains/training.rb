require "darwinning"

module OmahaBot
  module Brain
    class Training < ::Darwinning::Organism
      include Brain
      extend Brain::ClassMethods

      def decide
        raise winning_probability.inspect

        @decision = :all_in
      end

      def winning_probability
        @hand.winning_probability
      end

      def fitness
        0
      end
    end
  end
end
