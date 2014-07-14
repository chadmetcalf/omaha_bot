require 'open3'

module OmahaBot
  class Hand
    attr_accessor :hole_cards

    def initialize
      @hole_cards = []
      @winnning_probability = nil
    end

    def winning_probability
      @winning_probability ||= calculate_winning_probability
    end
    

    def calculate_winning_probability
      return 1
      return nil if hole_cards.empty?

      command = "./bin/pokenum  -o #{hole_cards.join(" ")} -  _ _ _ _"

      stdout,stderr,status = ::Open3.capture3(command)

      raise stdout.inspect

      STDERR.puts stderr
      if status.success?
        raise stdout.inspect
      else
        STDERR.puts "Probability Calculation not successful!"
      end
    end
  end
end
