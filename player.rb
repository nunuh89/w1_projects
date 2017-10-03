class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess
    puts "#{@name}, what is your input letter? "
    gets.chomp.downcase
  end

  def alert_invalid_guess
    puts "Invalid move. Please input again: "
  end

end
