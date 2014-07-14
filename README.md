omaha_bot
=========
Starter Bot for theaigames.com Omaha competitions. Ready for some brains.

###Minimum Viable Brain
A minimum viable Brain:
  - A ruby object in the ```OmahaBot::Brain``` namespace whose instance sets the ```@decision``` and ```@decision_amount``` in ```custom_brain#decide```.
  - Must have the ```Brain``` and ```Core``` modules mixed in to the ```CustomBrain``` class.
  - Must be registered in the ```Brain::REGISTERED_BRAINS``` constant with a symobol, i.e. ```:custom_brain```.

        module OmahaBot
          module Brain
            class CustomBrain
              # A Brain that folds like an oragami master
              include Core
              include Brain

              def decide
                @decision = :fold
                @decision_amount = nil
              end
            end
          end
        end

###Instantiate a brain
Let the Match know which brain to use for the player in ```Match#setup_player```.


###Executable
To scan the STDOUT run the executable ```./OmahaBot.rb``` from the command line.

###Run the parsing tests
To develop & run the parsing tests:

    bundle install
    rspec

###TODO
```Hand#calculate_winning_probability``` doesn't do anything yet.



