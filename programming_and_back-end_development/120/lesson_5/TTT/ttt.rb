require 'pry'
require_relative 'board.rb'
require_relative 'square.rb'
require_relative 'human.rb'
require_relative 'computer.rb'
require_relative 'minimax.rb'

class TTTGame
  NEGATIVE_INFINITY = -1.0/0.0
  POSITIVE_INFINITY = 1.0/0/0
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @current_player = nil
  end

  def play
    clear
    display_welcome_message
    set_markers
    set_first_player

    loop do
      display_board

      loop do
        current_player_moves
        break if break?
        clear_screen_and_display_board if human_turn?
      end
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end

    display_goodbye_message
  end

  private

  def clear
    system 'clear'
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're an #{human.marker}. Computer is an #{computer.marker}"
    puts ""
    board.draw
    puts ""
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

  def clear_screen_and_display_board
    clear
    display_board
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

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
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

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end

  def break?
    board.someone_won? || board.full?
  end

  def human_moves
    puts "Choose a square (#{joinor board.unmarked_keys, 'or'}): "
    square = human.move(board.unmarked_keys)
    board[square] = human.marker
  end

  def computer_moves
    board[max_move(board.squares, board.unmarked_keys.count, NEGATIVE_INFINITY, POSITIVE_INFINITY)[1]] = computer.marker
  end

  def human_turn?
    @current_player == human
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

  def update_state(state, move, marker)
    state_copy = state.dup
    state_copy[move] = marker
    state_copy
  end

  def max_move(state, depth, alpha, beta)
    return static_value(state, depth) if end_state?(state) or depth == 0
    v = [NEGATIVE_INFINITY, nil]

    possible_moves = get_next_moves(state)

    v_move = [v]
    possible_moves.each do |mv|
      new_state = update_state(state, mv, computer.marker)
      v_move << [min_value(new_state, depth-1, alpha, beta), mv]
    end
    v = v_move.max_by { |v, mv| v }
    alpha = [alpha, v[1]].max
    return alpha if alpha >= beta
    return v
  end

  def max_value(state, depth, alpha, beta)
    return static_value(state, depth) if end_states?(state) or depth == 0
    v = NEGATIVE_INFINITY

    possible_moves = get_next_moves(state)
    values = [v]

    possible_moves.each do |mv|
      new_state = update_state(state, mv, computer.marker)
      values << min_value(new_state, depth-1, alpha, beta)
    end
    v = values.max
    alpha = [alpha, v].max
    return alpha if alpha >= beta
    return v
  end

  def min_value(state, depth, alpha, beta)
    return static_value(state, depth) if end_states?(state) or depth == 0
    v = POSITIVE_INFINITY

    possible_moves = get_next_moves(state)
    values = [v]
    possible_moves.each do |mv|
      new_state = update_state(state, mv, human.marker)
      values << max_value(new_state, depth-1, alpha, beta)
    end
    v = values.min
    beta = [beta, v].min
    return beta if alpha >= beta
    return v
  end

  def static_value(state, depth)
    case winning_marker(state)
    when computer.marker
      10 - depth
    when human.marker
      depth - 10
    else
      0
    end
  end

  def winning_marker(state)
    Board::WINNING_LINES.each do |line|
      squares = state.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first
      end
    end
    nil
  end

  def three_identical_markers?(squares)
    markers = squares.select { |sq| sq != " " }
    return false if markers.size != 3
    markers.min == markers.max
  end


  def end_state?(state)
    board.someone_won?
  end

  def end_states?(state)
    Board::WINNING_LINES.each do |line|
      markers = state.values_at(*line).select { |marker| marker != " " }
      return false if markers.size != 3
      markers.min == markers.max
    end
    nil
  end

  def get_next_moves(state)
    state.select { |k, v| v == " " }.keys
  end
end

game = TTTGame.new
game.play
