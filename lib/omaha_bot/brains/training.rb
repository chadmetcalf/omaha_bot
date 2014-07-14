require "darwinning"

module OmahaBot
  class TrainingPlayer < ::Darwinning::Organism
    include Brain
    extend Brain::ClassMethods

    def decide
      @decision = :fold
    end

    def fitness
      0
    end
  end
end
