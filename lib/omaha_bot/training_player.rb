require "darwinning"

module OmahaBot
  class TrainingPlayer < ::Darwinning::Organism
    include Player

    def fitness
      0
    end
  end
end
