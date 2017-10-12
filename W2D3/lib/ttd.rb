class TTD

end

class Array
  def my_uniq
    r = []
    each do |e|
      r << e unless r.include?(e)
    end
    r
  end

  def two_sum
    r = []
    i = 0
    while i < self.length
      j = i + 1
      while j < self.length
        r << [i,j] if self[i] + self[j] == 0
        j += 1
      end
      i += 1
    end
      r
  end

  def my_transpose
    result = Array.new(self.length) {Array.new(self.length)}
    self.each_with_index do |row, row_idx|
      row.each_with_index do |elem, col_idx|
        result[col_idx][row_idx] = elem
      end
    end
    result
  end

  def stock_picker
    profit = 0
    r = [0,0]
    each_index do |day1|
      (day1+1...length).each do |day2|
        current_profit = self[day2] - self[day1]
        if current_profit > profit
          profit = current_profit
          r = [day1, day2]
        end
      end
    end
    r
  end

end

class Towers_Of_Hanoi
  attr_accessor :t1, :t2, :t3

  def initialize
    @t1 = [1,2,3]
    @t2 = []
    @t3 = []
    @towers = [@t1,@t2,@t3]
  end

  def move(from, to)
      to.insert(0, from.shift)
      render
  end

  def render
    puts "#{@t1.reverse}"
    puts "#{@t2.reverse}"
    puts "#{@t3.reverse}"
  end

  def play
    until won?
      render
      print "Please enter a move?: Ex:(0,1)"
      from, to  = gets.chomp.split(",").map(&:to_i)
      from_tower = @towers[from]
      to_tower = @towers[to]

      until valid_move?(from_tower, to_tower)
        print "Invalid move. Please enter a move?: Ex:(0,1)"
        from, to  = gets.chomp.split(",").map(&:to_i)
        from_tower = @towers[from]
        to_tower = @towers[to]
      end

      move(from_tower,to_tower)
    end
  end

  def valid_move?(from, to)
    return false if from.empty?
    return true if to.empty?
    disc = from.first
    to_disc = to.first
    return false if to_disc < disc
    true
  end

  def won?
    (@t1.empty?) && ((@t2.length == 3 && @t3.empty?)||(@t3.length == 3 && @t2.empty?))
  end

end
