describe OmahaBot do
  it "has settings" do
    expect(subject.settings).to be_a(OmahaBot::Settings)
  end

  it "has a match" do
    expect(subject.match).to be_a(OmahaBot::Match)
  end

  it "has a parser" do
    expect(subject.parser).to be_a(OmahaBot::Parser)
  end

  it "has a logger" do
    expect(subject.logger).to be_a(Logger)
  end
end
