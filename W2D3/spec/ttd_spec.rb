require 'ttd'
require 'rspec'

describe Array do
  describe "#my_uniq" do
    let(:array) {[1,2,1,3,3]}

    it "Removes duplicates from the array in the same order" do
      expect(array.my_uniq).to eq([1,2,3])
    end
  end

  describe '#two_sum' do
    let(:array) {[-1, 0, 2, -2, 1]}
    let(:temp) {array.two_sum}
    it "Returns the index of the elements sum to zero" do
      expect(temp).to eq([[0, 4], [2, 3]])
    end

    it "Returns [] when no pair is found" do
      expect([5, 5, 3, 1].two_sum).to eq([])
    end
  end

  describe '#my_transpose' do
    let(:array) {[
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
    ]}

    it "Returns the transposed array" do
      expect(array.my_transpose).to eq([[0, 3, 6],[1, 4, 7],[2, 5, 8]])
    end
  end

  describe '#stock_picker' do
    let(:array) { [100, 90, 80, 85, 110, 120, 90, 60, 70] }

    it "return the pairs with the most profits" do
      expect(array.stock_picker).to eq([2,5])
    end
  end
end

describe Towers_Of_Hanoi do
  let(:tower) {Towers_Of_Hanoi.new}

  describe '#initialize' do
    it "initialize a tower with first pile having three discs" do
      expect(tower.t1).to eq([1,2,3])
    end
    it "initialize a tower with second pile having no disc" do
      expect(tower.t2).to eq([])
    end
    it "initialize a tower with third pile having no disc" do
      expect(tower.t3).to eq([])
    end
  end

  describe '#move' do
    before(:each) {tower.move(tower.t1,tower.t2)}

    it "should remove a disc from tower 1" do
      expect(tower.t1).to eq([2,3])
    end

    it "correctly moves to tower 2" do
      expect(tower.t2).to eq([1])
    end

    it "does nothing to tower 3" do
      expect(tower.t3).to eq([])
    end
  end

  describe '#won?' do
    it "return true when game has won" do
      tower.t1 = []
      tower.t2 = []
      tower.t3 = [1,2,3]
      expect(tower.won?).to be true
    end

    it "return false if not won" do
      tower.t1 = []
      tower.t2 = [3]
      tower.t3 = [1,2]
      expect(tower.won?).to be false
    end
  end
end
