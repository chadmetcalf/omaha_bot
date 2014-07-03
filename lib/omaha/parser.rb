module Omaha
  class Parser
    def hear(string)
      args = string.split(" ")
      # klass = Omaha.const_get(args[0])

      case args[0]
      when 'Settings', 'Match'
        method = args[1].snakecaserize + "="
        send(args[0].downcase).send(method, args[2])
      end
    end

    private

    def settings
      Omaha.settings
    end

    def match
      Omaha.match
    end
  end
end
