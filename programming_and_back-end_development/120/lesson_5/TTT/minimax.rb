module Minimax
  NEGATIVE_INFINITY = -Float::INFINITY
  POSITIVE_INFINITY = Float::INFINITY

  def max_move(state, depth, alpha, beta, current_player)
    player = current_player
    return static_value(state, depth) if end_state?(state) || depth.zero?

    values_with_move = []
    possible_moves = get_next_moves(state.squares)
    possible_moves.each do |mv|
      new_state = Board.new(update_state(state.squares, mv, player.marker))
      values_with_move << [minimax(new_state, depth - 1, alpha,
                                   beta, next_turn(player)), mv]
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
      values << minimax(new_state, depth - 1, alpha, beta, next_turn(player))
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

  def next_turn(player)
    player == computer ? human : computer
  end

  def end_state?(state)
    state.someone_won?
  end

  def get_next_moves(state)
    state.select { |_k, v| v == " " }.keys
  end
end
