module OmahaBot
  class Parser
    include OmahaBot

    def hear(string)
      args = string.split(" ")

      case args[0]
      when 'Settings', 'Match'
        logger.debug "Parsing a #{args[0]}"

        send(args[0].downcase).send(prepared_method(args), prepared_data(args))
      end
      logger.debug match.inspect
    end

    private

    def prepared_data(args)
      if args[1] =~ /table/
        # "[7s,Js,3h]" => ["7s", "Js", "3h"]
        args[2][1..-2].split(",")
      else
        args[2]
      end

    end

    def prepared_method(args)
      args[1].snakecaserize + "="
    end
  end
end
