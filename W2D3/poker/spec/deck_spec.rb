require 'deck'
require 'rspec'

describe Deck do
  let(:new_deck) {Deck.new}
    describe '#initialize' do
      it "Creates a deck of 52 cards" do
        expect(new_deck.deck.count).to eq(52)
      end
    end

    describe '#draw' do
      it "Raises an error if number of cards drawn is greater than 5" do
        expect {new_deck.draw(8)}.to raise_error("Too many cards!")
      end
      it "Expected to return the requested number of cards" do
        expect(new_deck.draw(5).count).to eq(5)
      end
    end





end
