module OmahaBot
  module Brain
    class AllIn
      include Core
      include Brain

      def decide
        @decision = :all_in
      end

    end
  end
end
