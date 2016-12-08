
require_relative 'board.rb'
require_relative 'square.rb'
require_relative 'human.rb'
require_relative 'computer.rb'

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = "X".freeze
  COMPUTER_MARKER = "O".freeze
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @current_player = nil
  end

  def choose_marker
    human_marker = nil

    loop do
      print "Please choose your marker ('x' or 'o'): "
      human_marker = gets.chomp
      break if ['o','x'].include?(human_marker.downcase)
      puts "Invalid choice."
    end

    human_marker
  end

  def set_markers
    human_marker = choose_marker
    computer_marker = ['o', 'x'].select { |marker| marker != human_marker }

    human.set_marker(human_marker.upcase)
    computer.set_marker(computer_marker.upcase)
  end

  def play
    clear
    display_welcome_message
    set_markers

    loop do
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
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

  def human_moves
    puts "Choose a square (#{joinor board.unmarked_keys, 'or'}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
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
    @current_player = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end
end

game = TTTGame.new
game.play
