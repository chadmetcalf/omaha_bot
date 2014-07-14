module OmahaBot
  module Brain
    class Call
      include Core
      include Brain

      def decide
        @decision = :call
      end
    end
  end
end
