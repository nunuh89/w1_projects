require_relative 'player'


class Ghost
  ALPHABET = ("a".."z").to_a
  GHOST = "GHOST"

  def initialize(fragment, *players)
    @fragment = fragment
    @players = players
    @current_player = @players.first
    @previous_player = @players.last
    @dictionary = File.readlines("dictionary.txt").map(&:chomp)
    @losses = Hash.new(0)
  end

  def next_player!
    @previous_player = @current_player
    next_index = (@players.find_index(@current_player) + 1) % @players.length
    @current_player = @players[next_index]
  end

  def take_turn(player)
    guess = player.guess

    until valid_play?(guess)
      player.alert_invalid_guess
      guess = player.guess
    end
    next_player!
    puts "Fragment: #{@fragment}"
  end

  def valid_play?(string)
    false unless ALPHABET.include?(string.downcase)
    fragment_check = @fragment + string
    if @dictionary.any? { |word| word.start_with?(fragment_check) }
      @fragment = fragment_check
      true
    else
      false
    end
  end

  def lose_round?
    @dictionary.any? { |word| @fragment == word }
  end

  def record(player)
    lose_count = @losses[player.name]
    GHOST[0...lose_count]
  end

  def play_round
    until lose_round?
      take_turn(@current_player)
    end

    @losses[@previous_player.name] += 1
    puts "#{@previous_player.name} loses this round!"
    @fragment = ""
    puts "#{@previous_player.name}: #{record(@previous_player)}"
  end

  def run
    until @losses.has_value?(GHOST.length)
      play_round
    end

    puts "#{@previous_player.name} eliminated!"
  end

  def multi_run
    until @players.length == 1
      run
      @players -= [@previous_player]
      @losses.delete(@previous_player.name)
    end

    puts "Congrats! #{@players.first.name} wins the game!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Welcome to Ghost game!"
  player1 = Player.new("Trung")
  player2 = Player.new("Chi")
  player3 = Player.new("Comp")
  Ghost.new("", player1, player2, player3).multi_run
end
