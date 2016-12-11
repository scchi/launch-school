module GameLogic
  def clear
    system 'clear'
  end

  def play_prep
    clear
    display_welcome_message
    set_markers
    set_first_player
  end

  def set_markers
    human.marker, computer.marker = choose_markers
  end

  def choose_markers
    human_marker = human_choose_marker
    computer_marker = ['o', 'x'].select { |marker| marker != human_marker }[0]
    [human_marker, computer_marker]
  end

  def human_choose_marker
    marker = nil

    loop do
      print "Please choose your marker ('x' or 'o'): "
      marker = gets.chomp
      break if ['o', 'x'].include?(marker.downcase)
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
    if board.unmarked?(5)
      board[5] = computer.marker
    else
      board[max_move(board, calculate_depth, Minimax::NEGATIVE_INFINITY,
                     Minimax::POSITIVE_INFINITY, computer)[1]] = computer.marker
    end
  end

  def calculate_depth
    board.unmarked_keys.count
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

## Minimax implementation ##
module Minimax
  NEGATIVE_INFINITY = -1.0 / 0.0
  POSITIVE_INFINITY = 1.0 / 0.0

  def max_move(state, depth, alpha, beta, current_player)
    player = current_player
    return static_value(state, depth) if end_state?(state) || depth.zero?

    values_with_move = []
    possible_moves = get_next_moves(state.squares)
    possible_moves.each do |mv|
      new_state = Board.new(update_state(state.squares, mv, player.marker))
      values_with_move << [minimax(new_state, depth - 1, alpha,
                                   beta, next_player(player)), mv]
    end

    values_with_move << [NEGATIVE_INFINITY, nil]
    top_level_alpha_beta(values_with_move, alpha, beta)
  end

  def minimax(state, depth, alpha, beta, player)
    return static_value(state, depth) if end_state?(state) || depth.zero?

    values = []

    possible_moves = get_next_moves(state.squares)
    possible_moves.each do |mv|
      new_state = Board.new(update_state(state.squares, mv, player.marker))
      values << minimax(new_state, depth - 1, alpha, beta, next_player(player))
    end

    alpha_beta_pruning(player, values, alpha, beta)
  end

  def top_level_alpha_beta(values_with_move, alpha, beta)
    max_values_with_move = values_with_move.max_by { |v, _mv| v }
    alpha = [alpha, max_values_with_move[1]].max
    alpha >= beta ? alpha : max_values_with_move
  end

  def alpha_beta_pruning(player, values, alpha, beta)
    if player == computer
      values << NEGATIVE_INFINITY
      optimal_value = values.max
      alpha = [alpha, optimal_value].max
      return alpha if alpha >= beta
    else
      values << POSITIVE_INFINITY
      optimal_value = values.min
      beta = [beta, optimal_value].min
      return beta if alpha >= beta
    end

    optimal_value
  end

  def update_state(state, move, marker)
    state_copy = state.dup
    state_copy[move] = marker
    state_copy
  end

  def static_value(state, depth)
    case state.winning_marker
    when computer.marker
      10 - depth
    when human.marker
      depth - 10
    else
      0
    end
  end

  def next_player(player)
    player == computer ? human : computer
  end

  def end_state?(state)
    state.someone_won?
  end

  def get_next_moves(state)
    state.select { |_k, v| v == " " }.keys
  end
end
