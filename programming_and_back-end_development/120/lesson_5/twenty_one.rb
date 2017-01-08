module Displayable
  def welcome_message
    puts "Welcome to Twenty-One!"
    puts ""
  end

  def show_stats_after_move
    show_game_points
    show_initial_cards
  end

  def show_cards
    puts "You had:"
    human.show_hand
    puts ""
    puts "Dealer had:"
    dealer.show_hand
    puts ""
  end

  def show_initial_cards
    puts "You have:"
    human.show_hand
    puts ""
    dealer.show_initial_hand
    puts ""
  end

  def show_result
    winner = determine_winner
    puts ""

    case winner
    when :tie then puts "It's a tie"
    else puts "#{winner.to_s.capitalize} won!"
    end
    puts ""

    show_cards
    show_score
    puts "-" * 20
  end

  def show_score
    puts "Card Points:"
    puts "You: #{human.card_points}, Dealer: #{dealer.card_points}"
    puts ""
    show_game_points
  end

  def show_game_points
    puts "Game Points:"
    puts "You: #{human_score}, Dealer: #{dealer_score}"
    puts ""
  end

  def show_game_result
    human_score == 3 ? (puts "You won!") : (puts "Dealer won!")
  end

  def clear_screen
    system 'clear'
    system 'cls'
  end

  def goodbye
    puts "Thank you for playing Twenty One!"
  end

  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
    end

    answer == 'y'
  end
end

class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class NumberCard < Card
  def value
    rank
  end
end

class FaceCard < Card
  def value
    10
  end
end

class AceCard < Card
  def value
    11
  end
end

class Deck
  attr_accessor :deck

  SUITS = ["\u2663", "\u2662", "\u2661", "\u2660"].freeze
  NUMBER_RANK = (2..10).to_a
  FACE_RANK = ["King", "Queen", "Jack"].freeze

  def initialize
    @deck = []

    SUITS.each do |suit|
      deck << AceCard.new("Ace", suit)

      NUMBER_RANK.each do |rank|
        deck << NumberCard.new(rank, suit)
      end

      FACE_RANK.each do |rank|
        deck << FaceCard.new(rank, suit)
      end
    end

    deck.shuffle!
  end

  def deal
    deck.pop
  end
end

class Hand
  include Enumerable

  attr_accessor :total_value, :cards

  def initialize
    @cards = []
    @total_value = 0
  end

  def <<(card)
    cards << card
    self.total_value += card.value
  end

  def number_of_aces
    cards.count { |card| card.instance_of? AceCard }
  end

  def card_points
    card_points = total_value
    number_of_aces.times { card_points -= 10 if card_points > 21 }
    card_points
  end

  def show_hand
    cards.each { |card| puts card }
  end

  def clear_hand
    cards.clear
  end

  def clear_score
    self.total_value = 0
  end
end

class Player
  attr_reader :hand
  attr_accessor :cards

  def initialize
    @hand = Hand.new
  end

  def <<(card)
    hand << card
  end

  def clear_hand
    hand.clear_hand
  end

  def clear_score
    hand.clear_score
  end

  def show_hand
    hand.show_hand
  end

  def card_points
    hand.card_points
  end
end

class Dealer < Player
  def show_initial_hand
    puts "Dealer has:"
    puts "#{hand.cards.first} and an unkown card."
  end
end

class Game
  include Displayable

  ROUNDS_TO_WIN = 3
  BUSTED_VALUE = 21

  attr_reader :human, :dealer
  attr_accessor :human_score, :dealer_score, :deck

  def initialize
    @deck = nil
    @human = Player.new
    @dealer = Dealer.new
    @human_score = 0
    @dealer_score = 0
  end

  def deal_cards
    2.times do
      human << deck.deal
      dealer << deck.deal
    end
  end

  def human_turn
    loop do
      answer = nil

      loop do
        puts "Would you like to 'h'it, 's'tay, or 'q'uit?"
        answer = gets.chomp.downcase
        break if ["h", "s", "q"].include?(answer)
        puts "Sorry, invalid choice."
      end

      clear_screen
      break if answer == 's'
      throw :quit if answer == 'q'
      hit(human)
      break if busted?(human)
      show_stats_after_move
    end
  end

  def busted?(player)
    player.card_points > BUSTED_VALUE
  end

  def hit(player)
    player << deck.deal
  end

  def dealer_turn
    hit(dealer) until dealer.card_points >= 17
  end

  def determine_winner
    if human.card_points > dealer.card_points then :you
    elsif human.card_points < dealer.card_points then :dealer
    else :tie
    end
  end

  def update_score
    case determine_winner
    when :you then self.human_score += 1
    when :dealer then self.dealer_score += 1
    end
  end

  def someone_won?
    [human_score, dealer_score].include?(ROUNDS_TO_WIN)
  end

  def clear_round_stats
    clear_hand
    clear_score
  end

  def clear_hand
    human.clear_hand
    dealer.clear_hand
  end

  def clear_score
    human.clear_score
    dealer.clear_score
  end

  def game_prep
    self.deck = Deck.new
    self.human_score = 0
    self.dealer_score = 0
    clear_screen
  end

  def human_busted
    clear_screen
    puts "You busted. Dealer won!"
    self.dealer_score += 1
    show_cards
    show_score
    puts "-" * 20
  end

  def dealer_busted
    clear_screen
    puts "Dealer busted. You won!"
    self.human_score += 1
    show_cards
    show_score
    puts "-" * 20
  end

  def round_prep
    clear_round_stats
    deal_cards
    show_initial_cards
  end

  def play_round
    loop do
      break if someone_won?
      round_prep
      human_turn
      next(human_busted) if busted?(human)
      puts "You stayed."
      dealer_turn
      next(dealer_busted) if busted?(dealer)
      puts "Dealer stayed."
      update_score
      show_result
    end
  end

  def start
    clear_screen
    welcome_message
    catch :quit do
      loop do
        game_prep
        play_round
        show_game_result
        break unless play_again?
      end
    end
    clear_screen
    goodbye
  end
end

Game.new.start
