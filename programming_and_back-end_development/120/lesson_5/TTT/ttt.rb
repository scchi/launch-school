require 'pry'
require_relative 'board.rb'
require_relative 'game_logic.rb'
require_relative 'display.rb'

class Computer
  attr_reader :marker, :moves

  def set_marker(marker)
    @marker = marker
  end
end

class Human
  attr_reader :marker

  def set_marker(marker)
    @marker = marker
  end

  def move(unmarked_keys)
    square = nil

    loop do
      square = gets.chomp.to_i
      break if unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    square
  end
end

class TTTGame
  include GameLogic
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
