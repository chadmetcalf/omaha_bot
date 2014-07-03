module Omaha
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
    describe "Match state" do
      let(:match) { Match.new }
      before(:each) do
        allow(subject).to receive(:match) { match }
      end

      it 'round' do
        expect{parser.hear("Match round 1")}.
          to change{match.round}.from(nil).to("1")
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
    end

  end
end
