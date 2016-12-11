module GameLogic
  NEGATIVE_INFINITY = -1.0/0.0
  POSITIVE_INFINITY = 1.0/0/0

  def clear
    system 'clear'
  end

  def set_markers
    human_marker = choose_marker
    computer_marker = ['o', 'x'].select { |marker| marker != human_marker }[0]

    human.set_marker(human_marker.upcase)
    computer.set_marker(computer_marker.upcase)
  end

  def choose_marker
    marker = nil

    loop do
      print "Please choose your marker ('x' or 'o'): "
      marker = gets.chomp
      break if ['o','x'].include?(marker.downcase)
      puts "Invalid choice."
    end

    marker
  end

  def set_first_player
    first_player = nil

    loop do
      print "Would you like to go first? (y/n) "
      first_player = gets.chomp
      break if ['y', 'n'].include?(first_player.downcase)
      puts "Invalid choice."
    end

    first_player == 'y' ? @current_player = human : @current_player = computer
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_player = computer
    else
      computer_moves
      @current_player = human
    end
  end

  def human_turn?
    @current_player == human
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Choose a square (#{joinor board.unmarked_keys, 'or'}): "
    square = human.move(board.unmarked_keys)
    board[square] = human.marker
  end

  def break?
    board.someone_won? || board.full?
  end

  def joinor(array, delim)
    case array.size
    when 1
      array[0]
    when 2
      array.join(" #{delim} ")
    else
      array[0..-2].join(', ') + " #{delim} " + array[-1].to_s
    end
  end

  def computer_moves
    board[max_move(board.squares, board.unmarked_keys.count, NEGATIVE_INFINITY, POSITIVE_INFINITY)[1]] = computer.marker
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def reset
    board.reset
    set_first_player
    clear
  end
end
