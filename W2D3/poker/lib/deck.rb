require_relative 'card.rb'

class Deck
  attr_reader :deck

  def self.new_deck
      deck = []
      SUITS.keys.each do |suit|
        VALUES.keys.each do |value|
          deck << Card.new(suit, value)
        end
      end
      deck
  end

  def initialize
    @deck = Deck.new_deck
  end

  def draw(num_of_cards)
    raise "Too many cards!" if num_of_cards > 5
    card_in_hand = []

    @deck.shuffle!

    num_of_cards.times do
      card_in_hand << @deck.pop
    end
    card_in_hand
  end

end
