require_relative 'board.rb'
require_relative 'minimax.rb'
require_relative 'displayable.rb'

class Player
  attr_accessor :marker
end

class Human < Player
  def move(unmarked_keys)
    square = nil

    loop do
      square = gets.chomp.to_i
      break if unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    square
  end

  def choose_marker
    marker = nil

    loop do
      print "Please choose your marker ('x' or 'o'): "
      marker = gets.chomp
      break if ['o', 'x'].include?(marker.downcase)
      puts "Invalid choice."
    end

    marker
  end

  def go_first?
    answer = nil

    loop do
      print "Would you like to go first? (y/n) "
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Invalid choice."
    end

    answer == 'y'
  end
end

class TTTGame
  include Displayable
  include Minimax
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Player.new
    @current_player = nil
  end

  def play
    play_prep

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
    human_marker = human.choose_marker
    computer_marker = ['o', 'x'].select { |marker| marker != human_marker }[0]
    [human_marker, computer_marker]
  end

  def set_first_player
    @current_player = human.go_first? ? human : computer
  end

  def current_player_moves
    human_turn? ? human_moves : computer_moves
    @current_player = next_player
  end

  def next_player
    human_turn? ? computer : human
  end

  def human_turn?
    @current_player == human
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
      board[max_move(board, calculate_depth, NEGATIVE_INFINITY,
                     POSITIVE_INFINITY, computer)[1]] = computer.marker
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

game = TTTGame.new
game.play
