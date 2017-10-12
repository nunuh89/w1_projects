require 'card'
require 'rspec'

describe Card do
  let(:card) {Card.new(:spade, :ten)}
  describe '#initialize' do
    it "Initializes a card with a suit and value" do
      expect(card.suit).to eq(:spade)
      expect(card.value).to eq(:ten)
    end
  end

  describe '#to_s' do
    it "Converts the card to a string" do
      expect(card.to_s).to eq('Spades 10')
    end

  end

end
