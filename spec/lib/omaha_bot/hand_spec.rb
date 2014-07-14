module OmahaBot
  describe Hand do
    subject(:hand) { Hand.new }

    it "has a winning probability" do
      hand.hole_cards = ['8h', '8s', '5d', '6s']

      expect(hand.winning_probability).to eq(0.24)
    end
  end
end
