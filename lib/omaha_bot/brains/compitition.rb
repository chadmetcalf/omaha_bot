module OmahaBot
  module Brain
    class Compitition
      include Brain
      extend Brain::ClassMethods

      def decide
        @decision = :fold
      end
    end
  end
end
