describe Omaha do
  it "has settings" do
    expect(subject.settings).to be_a(Omaha::Settings)
  end

  it "has a match" do
    expect(subject.match).to be_a(Omaha::Match)
  end
end
