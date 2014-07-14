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

    def player_hear(player, args)
      case args[1]
      when "post"
        player.post(args[2].to_i)
      when "hand"
        hand = parse_cards(args[2])
      when "wins"
        match.finish_hand
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
