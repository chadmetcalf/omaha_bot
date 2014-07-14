module OmahaBot
  class Parser
    include Core

    def hear(string)
      args = string.split(" ")

      case args[0]
      when 'Settings', 'Match'
        send(args[0].downcase).send(prepared_method(args), prepared_data(args))
      when 'Action'
        if args[1] == settings.your_bot
          player.act
        end
      when /player/i
        if args[0] == settings.your_bot
          player_hear(player, args)
        else
          player_hear(opponent, args)
        end
      end
      logger.debug match.inspect
    end

    private

    def player_hear(listener, args)
      logger.debug args.join(" ")
      case args[1]
      when "hand"
        listener.hole_cards= parse_cards(args[2])
      when "wins"
        logger.debug "     -> pot = #{match.pot}"
        match.finish_hand(listener)
      when "stack"
        logger.debug "     -> #{args[0]} stack = #{listener.stack}"
        unless listener.stack == args[2].to_i
          error_string = "Stack difference error!\n"\
            "     -> Player Stack: #{listener.stack}\n"\
            "     -> Input: #{args[2]}"
          logger.debug error_string
        end
        # The local arena does not keep track of blinds correctly
        # Update the stack every time it is read
        listener.stack = args[2].to_i
      when "call", "raise", "post"
        listener.push_chips(args[2].to_i)
        player.decide if listener == opponent
      end
    end

    def prepared_method(args)
      args[1].snakecaserize + "="
    end

    def prepared_data(args)
      if args[1] =~ /table/
        # "[7s,Js,3h]" => ["7s", "Js", "3h"]
        parse_cards(args[2])
      else
        args[2]
      end
    end

    def parse_cards(string)
      string[1..-2].split(",")
    end

    def player
      match.player
    end

    def opponent
      match.opponent
    end

    def players
      match.players
    end
  end
end
