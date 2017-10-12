require_relative 'card.rb'

class Hand

  attr_accessor :cards

  def initialize
    @cards = []
  end

  def beats?(other_hand)
    if ranking(other_hand.cards) < ranking(@cards)
      return false
    else
      return true
    end
  end

  def ranking(hand)
    if straight_flush(hand)
      return 1
    elsif four_kind(hand)
      return 2
    elsif full_house(hand)
      return 3
    elsif flush(hand)
      return 4
    elsif straight(hand)
      return 5
    elsif three_kind(hand)
      return 6
    elsif two_pair(hand)
      return 7
    else
      return 8
    end
  end


  def straight_flush(hand)
    current_suit = hand.first.suit
    hand_values = []

    hand.each do |card|
      hand_values << card.value
    end

    flush = hand.all? {|card| card.suit == current_suit}
    straight = hand_values.sort.each_cons(2).all? { |x,y| y == x + 1 }
    flush && straight
  end

  def four_kind(hand)
    count = Hash.new(0)
    hand.each do |card|
      count[card.value] += 1
    end
    count.values.include?(4)
  end

  def full_house(hand)
    count = Hash.new(0)
    hand.each do |card|
      count[card.value] += 1
    end
    count.keys.count == 2 && count.values.include?(3)
  end

  def flush(hand)
    current_suit = hand.first.suit
    hand.all? {|card| card.suit == current_suit}
  end

  def straight(hand)
    hand_values = []

    hand.each do |card|
      hand_values << card.value
    end

    hand_values.sort.each_cons(2).all? { |x,y| y == x + 1 }
  end

  def three_kind(hand)
    count = Hash.new(0)
    hand.each do |card|
      count[card.value] += 1
    end
    count.values.include?(3)
  end

  def two_pair(hand)
    count = Hash.new(0)
    hand.each do |card|
      count[card.value] += 1
    end
    count.keys.count == 3
  end

  def one_pair(hand)
    count = Hash.new(0)
    hand.each do |card|
      count[card.value] += 1
    end
    count.keys.count == 4
  end

end
