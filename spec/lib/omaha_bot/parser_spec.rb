module OmahaBot
  describe Parser do
    subject(:parser) { Parser.new }

    # Settings timeBank 5000
    # Settings timePerMove 500
    # Settings handsPerLevel 10
    # Settings startingStack 1500
    # Settings yourBot player1
    context "settings" do
      let(:settings) { Settings.new }
      before(:each) do
        allow(subject).to receive(:settings) { settings }
      end

      it 'time bank' do
        expect{parser.hear("Settings timeBank 5000")}.
          to change{settings.time_bank}.from(nil).to("5000")
      end

      it 'time per move' do
        expect{parser.hear("Settings timePerMove 500")}.
          to change{settings.time_per_move}.from(nil).to("500")
      end

      it 'hands per level' do
        expect{parser.hear("Settings handsPerLevel 10")}.
          to change{settings.hands_per_level}.from(nil).to("10")
      end

      it 'starting stack' do
        expect{parser.hear("Settings startingStack 1500")}.
          to change{settings.starting_stack}.from(nil).to("1500")
      end

      it 'your bot' do
        expect{parser.hear("Settings yourBot player1")}.
          to change{settings.your_bot}.from(nil).to("player1")
      end
    end

    # Match round 1
    # Match smallBlind 15
    # Match bigBlind 30
    # Match onButton player1
    context "Match" do
      let(:match) { Match.new }
      before(:each) do
        allow(parser).to receive(:match) { match }
      end

      it 'round' do
        allow(match).to receive(:start_hand) { true }

        expect{parser.hear("Match round 1")}.
          to change{match.round}.from(nil).to(1)
      end

      it 'small blind' do
        expect{parser.hear("Match smallBlind 15")}.
          to change{match.small_blind}.from(nil).to("15")
      end

      it 'big blind' do
        expect{parser.hear("Match bigBlind 30")}.
          to change{match.big_blind}.from(nil).to("30")
      end

      it 'on button' do
        expect{parser.hear("Match onButton player1")}.
          to change{match.on_button}.from(nil).to("player1")
      end

      it "max win pot" do
        expect{parser.hear("Match maxWinPot 45")}.
          to change{match.max_win_pot}.from(nil).to(45)
      end

      it "amount to call" do
        expect{parser.hear("Match amountToCall 15")}.
          to change{match.amount_to_call}.from(nil).to(15)
      end

      context "table" do
        it "flop" do
          expect{parser.hear("Match table [7s,Js,3h]")}.
            to change{match.table}.from([]).to(['7s','Js','3h'])
        end

        it "turn" do
          match.table = ['7s','Js','3h']

          expect{parser.hear("Match table [7s,Js,3h,5d]")}.
            to change{match.table}.from(['7s','Js','3h']).
              to(['7s', 'Js', '3h', '5d'])
        end

        it "river" do
          match.table = ['7s','Js','3h', '5d']

          expect{parser.hear("Match table [7s,Js,3h,5d,9s]")}.
            to change{match.table}.from(['7s','Js','3h', '5d']).
              to(['7s', 'Js', '3h', '5d', '9s'])
        end
      end
    end

    # Action b t
    context "Action" do
      let(:match)  {double "match"}
      let(:player) {double "player"}

      before(:each) do
        allow(parser).to receive(:match) { match }
        allow(parser).to receive(:player) { player }
      end

      it "player is player1" do
        parser.settings.your_bot = "player1"

        expect(player).to receive(:act).once

        parser.hear("Action player1 5000")
        parser.hear("Action player2 5000")
      end

      it "player is player2" do
        parser.settings.your_bot = "player2"

        expect(player).to receive(:act).once

        parser.hear("Action player1 5000")
        parser.hear("Action player2 5000")
      end
    end

    context "Player" do
      let(:match)  {Match.new}
      let(:player) {Player.new(:call)}

      before(:each) do
        allow(parser).to receive(:match)  { match }
        allow(match).to  receive(:player) { player }
        allow(parser).to receive(:player) { player }
      end

      it  "starts a hand" do
        expect(player).to receive(:start_hand).once

        parser.hear("Match round 1")
      end

      it "has a hand" do
        player.start_hand
        parser.settings.your_bot = "player1"

        expect{parser.hear("player1 hand [8h,8s,5d,6s]")}.
          to change{player.hand.hole_cards}.from([]).
            to(['8h', '8s', '5d', '6s'])
      end

      it "wins a hand" do
        parser.settings.your_bot = "player1"
        expect(parser.match).to receive(:finish_hand)

        parser.hear("player1 wins 360")
      end
    end
  end
end
