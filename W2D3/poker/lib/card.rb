SUITS = {
  :spade => "Spades",
  :diamond => "Diamond",
  :hearts => "Hearts",
  :clubs => "Clubs"
}

VALUES = {
  1 => "Ace",
  2 => "Two",
  3 => "Three",
  4 => "Four",
  5 => "Five",
  6 => "Six",
  7 => "Seven",
  8 => "Eight",
  9 => "Nine",
  10 => "Ten",
  11 => "Jack",
  12 => "Queen",
  13 => "King"
}

class Card

  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    "#{SUITS[@suit]} #{VALUES[@value]}"
  end






end
