require_relative 'board.rb'
require_relative 'game_logic.rb'
require_relative 'displayable.rb'

class Computer
  attr_accessor :marker
end

class Human
  attr_accessor :marker

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
  include Displayable
  include GameLogic
  include Minimax
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
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
end

game = TTTGame.new
game.play
