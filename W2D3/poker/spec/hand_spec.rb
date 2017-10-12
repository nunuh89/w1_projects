require 'hand'
require 'rspec'

describe Hand do
  let(:new_hand) {Hand.new}
  let(:new_hand2) {Hand.new}
  describe '#initialize' do
    it "Hand initializes an empty array of cards" do
      expect(new_hand.cards).to eq([])
    end
  end

  describe '#beats?(other_hand)' do
    let(:cards1) {[
      double('card1', :suit => :hearts, :value => 1),
      double('card2', :suit => :spade, :value => 1),
      double('card3', :suit => :clubs, :value => 1),
      double('card4', :suit => :diamond, :value => 1),
      double('card5', :suit => :hearts, :value => 2),
      ]}
      let(:cards2) {[
        double('card1', :suit => :hearts, :value => 1),
        double('card2', :suit => :spade, :value => 1),
        double('card3', :suit => :clubs, :value => 1),
        double('card4', :suit => :diamond, :value => 1),
        double('card5', :suit => :hearts, :value => 2),
        ]}
    it "Returns true if self beats other hand" do
      new_hand.cards = cards1
      new_hand2.cards = cards2
      expect(new_hand.beats?(new_hand2)).to be true
    end
  end

  describe '#ranking(hand)' do
    it "Returns 1 if straight_flush" do
      expect(ranking(new_hand)).to eq()
    end
  end

  describe '#four_kind(hand)' do
    let(:cards) {[
      double('card1', :suit => :hearts, :value => 1),
      double('card2', :suit => :spade, :value => 1),
      double('card3', :suit => :clubs, :value => 1),
      double('card4', :suit => :diamond, :value => 1),
      double('card5', :suit => :hearts, :value => 2),
                  ]}
    it "Returns true if hand is a four of a kind" do
      expect(new_hand.four_kind(cards)).to be true
    end
  end

  describe '#straight_flush(hand)' do
    let(:cards) {[
      double('card1', :suit => :spade, :value => 1),
      double('card2', :suit => :spade, :value => 2),
      double('card3', :suit => :spade, :value => 3),
      double('card4', :suit => :spade, :value => 4),
      double('card5', :suit => :spade, :value => 5),
                  ]}
    it "Returns true if hand is a straight_flush" do
      expect(new_hand.straight_flush(cards)).to be true
    end
  end
  describe '#full_house(hand)' do
    let(:cards) {[
      double('card1', :suit => :hearts, :value => 1),
      double('card2', :suit => :spade, :value => 1),
      double('card3', :suit => :clubs, :value => 1),
      double('card4', :suit => :diamond, :value => 2),
      double('card5', :suit => :hearts, :value => 2),
                  ]}
    it "Returns true if hand is a full_house" do
      expect(new_hand.full_house(cards)).to be true
    end
  end

  describe '#flush(hand)' do
    let(:cards) {[
      double('card1', :suit => :hearts, :value => 1),
      double('card2', :suit => :hearts, :value => 1),
      double('card3', :suit => :hearts, :value => 1),
      double('card4', :suit => :hearts, :value => 1),
      double('card5', :suit => :hearts, :value => 2),
                  ]}
    it "Returns true if hand is a flush" do
      expect(new_hand.flush(cards)).to be true
    end
  end

  describe '#straight(hand)' do
    let(:cards) {[
      double('card1', :suit => :spade, :value => 1),
      double('card2', :suit => :spade, :value => 2),
      double('card3', :suit => :spade, :value => 3),
      double('card4', :suit => :spade, :value => 4),
      double('card5', :suit => :spade, :value => 5),
                  ]}
    it "Returns true if hand is a straight" do
      expect(new_hand.straight(cards)).to be true
    end
  end

  describe '#three_kind(hand)' do
    let(:cards) {[
      double('card1', :suit => :hearts, :value => 1),
      double('card2', :suit => :spade, :value => 1),
      double('card3', :suit => :clubs, :value => 1),
      double('card4', :suit => :diamond, :value => 2),
      double('card5', :suit => :hearts, :value => 2),
                  ]}
    it "Returns true if hand is a three_kind" do
      expect(new_hand.three_kind(cards)).to be true
    end
  end







end
