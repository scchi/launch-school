# ROCK, PAPER, SCISSORS, LIZARD SPOCK
# - each game is a race to 10 points
# - Computer player is one of R2D2, Hal, Sonny, Number 5, and Chappie.
#   Each computer has its own playing style as follows:
#    * R2D2 chooses moves at random
#    * Hal prefers rock
#    * Chappie adjusts every move depending on 1.) the human player's
#      previous move and 2.) if human player won or lost
#    * Sonny likes scissors and spock
#    * Number 5 chooses the move that can beat the most
#      frequent move used by human player
module Display
  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    puts
  end

  def display_winner
    if determine_winner == human
      puts "#{human.name} won!"
    elsif determine_winner == computer
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
    puts
  end

  def display_score
    puts "#{human.name}: #{human.score}"
    puts "#{computer.name}: #{computer.score}"
    puts
  end

  def display_game_winner
    if human.score == 10
      puts "#{human.name} won!"
    else
      puts "#{computer.name} won!"
    end
  end

  def clear_screen
    system 'clear'
  end

  def display_commentary(first, action, second)
    puts "#{first} #{action} #{second}!"
  end
end

class Move
  attr_reader :value
  VALUES = ['rock', 'paper', 'scissors', 'spock', 'lizard'].freeze

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def spock?
    @value == 'spock'
  end

  def lizard?
    @value == 'lizard'
  end

  def ==(other_move)
    value == other_move.value
  end

  def >(other_move)
    comparison_hash = { 'rock' => ['scissors', 'lizard'],
                        'paper' => ['rock', 'spock'],
                        'scissors' => ['paper', 'lizard'],
                        'spock' => ['rock', 'scissors'],
                        'lizard' => ['spock', 'paper'] }
    comparison_hash[value].include?(other_move.value)
  end

  def <(other_move)
    comparison_hash = { 'rock' => ['spock', 'paper'],
                        'paper' => ['lizard', 'scissors'],
                        'scissors' => ['spock', 'rock'],
                        'spock' => ['paper', 'lizard'],
                        'lizard' => ['rock', 'scissors'] }
    comparison_hash[value].include?(other_move.value)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score, :history

  def initialize
    set_name
    @score = 0
    @history = []
  end
end

class Human < Player
  def set_name
    name = ""

    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty? || !(name =~ /[^\s]/)
      puts "Sorry, must enter a value."
    end

    self.name = name
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, spock:"
      puts "'r' rock, 'p' paper, 's' scissors, 'l' lizard, 'sp' spock"
      choice = gets.chomp.downcase
      break if (Move::VALUES + ['r', 'p', 's', 'l', 'sp']).include? choice
      puts "Sorry, invalid choice."
    end

    choice = choice_to_move(choice) if choice.size <= 2
    self.move = Move.new(choice)
  end

  def choice_to_move(choice)
    case choice
    when 'r' then 'rock'
    when 'p' then 'paper'
    when 's' then 'scissors'
    when 'l' then 'lizard'
    when 'sp' then 'spock'
    end
  end
end

class Computer < Player
  attr_accessor :gameplay

  def initialize
    super
    @gameplay = Gameplay.new(name)
  end

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(gameplay.pick_weighted)
  end

  def adjust_gameplay(winner, move, history)
    chappie_adjust(winner, move) if name == 'Chappie'
    number_5_adjust(history) if name == 'Number 5'
  end

  def chappie_adjust(winner, move)
    next_move = []
    if winner.instance_of?(Human)
      next_move = Move::VALUES.select do |mv|
        move < Move.new(mv)
      end
    elsif winner.instance_of?(Computer)
      next_move << move.value
    end
    gameplay.adjust_weights(next_move)
  end

  def number_5_adjust(history)
    move_frequency = Hash.new
    Move::VALUES.each { |move| move_frequency[move] = history.count(move) }
    sorted_moves = move_frequency.sort_by { |_move, count| count }
    frequent_move = Move.new(sorted_moves.flatten[-2])

    next_move = ''
    Move::VALUES.each do |move|
      if frequent_move < Move.new(move)
        next_move = move
        break
      end
    end
    gameplay.adjust_weights_5(next_move)
  end
end

class Gameplay
  attr_accessor :weights, :prob_dist

  def initialize(name)
    @weights = pick_weights(name)
    @prob_dist = Move::VALUES.zip(@weights).to_h
  end

  def pick_weights(name)
    case name
    when 'Hal' then [60, 70, 80, 90, 100]
    when 'Sonny' then [10, 20, 55, 65, 100]
    when 'Number 5' then [0, 0, 0, 100, 0]
    else [20, 40, 60, 80, 100]
    end
  end

  def pick_weighted
    target = rand(100)

    next_move = ""
    prob_dist.each do |move, weight|
      if target <= weight
        next_move = move
        break
      end
    end
    next_move
  end

  def adjust_weights(next_move)
    @prob_dist.each_key { |key| @prob_dist[key] = 0 }
    cumulative_weight = 0
    @prob_dist.each do |move, _weight|
      if next_move.include?(move)
        next_move.size > 1 ? cumulative_weight += 35 : cumulative_weight += 40
      else
        next_move.size > 1 ? cumulative_weight += 10 : cumulative_weight += 15
      end
      prob_dist[move] = cumulative_weight
    end
  end

  def adjust_weights_5(next_move)
    @prob_dist.each_key { |key| @prob_dist[key] = 0 }
    @prob_dist[next_move] = 100
  end
end

class RPSGame
  include Display
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def update_history
    human.history << human.move.value
    computer.history << computer.move.value
  end

  def determine_winner
    if human.move > computer.move
      human
    elsif human.move < computer.move
      computer
    else
      'tie'
    end
  end

  def commentary
    action = determine_action

    if determine_winner == human
      first = human.move.to_s
      second = computer.move.to_s
    else
      first = computer.move.to_s
      second = human.move.to_s
    end

    display_commentary(first, action, second)
  end

  def determine_action
    moves_to_action = { ['paper', 'scissors'] => 'CUTS',
                        ['paper', 'rock'] => 'COVERS',
                        ['lizard', 'rock'] => 'CRUSHES',
                        ['lizard', 'spock'] => 'POISONS',
                        ['scissors', 'spock'] => 'SMASHES',
                        ['lizard', 'scissors'] => 'DECAPITATES',
                        ['lizard', 'paper'] => 'EATS',
                        ['paper', 'spock'] => 'DISPROVES',
                        ['rock', 'spock'] => 'VAPORIZERS',
                        ['rock', 'scissors'] => 'CRUSHES' }

    players_move = [human.move.value, computer.move.value].sort
    moves_to_action[players_move]
  end

  def update_score
    if human.move > computer.move
      human.score += 1
    elsif human.move < computer.move
      computer.score += 1
    end
  end

  def someone_won?
    human.score == 10 || computer.score == 10
  end

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def play_again?
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      return false if answer.casecmp('n') == 0
      return true if answer.casecmp('y') == 0
      puts "Sorry, must be y or n."
    end
  end

  def computer_adjust
    if computer.name == 'Chappie' || computer.name == 'Number 5'
      computer.adjust_gameplay(determine_winner, human.move, human.history)
    end
  end

  def display_result
    display_moves
    commentary unless human.move == computer.move
    display_winner
    display_score
  end

  def match
    loop do
      human.choose
      computer.choose
      update_history
      clear_screen
      update_score
      display_result
      computer_adjust
      break if someone_won?
    end
  end

  def play
    display_welcome_message
    loop do
      match
      clear_screen
      display_score
      display_game_winner
      reset_score
      break unless play_again?
    end
    clear_screen
    display_goodbye_message
  end
end

RPSGame.new.play
