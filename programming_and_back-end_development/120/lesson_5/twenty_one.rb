require 'pry'
class Player < Participant
  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Dealer < Participant
  def deal
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Participant
  attr_reader :cards

  def initialize
    @cards = []
  end

  def busted?

    cards.each do |card|

  end
end

class Deck
  def initialize
    @cards = []

    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        @cards << Card.new(suit, face)
      end
    end

    @cards.shuffle!
  end

  def deal(player)
    player.cards << @cards.pop()
  end
end

class Card
  SUITS = ['H', 'D', 'S', 'C']
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "#{face} of #{suit}"
  end

  def face
    case @face
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else
      @face
    end
  end

  def suit
    case @suit
    when 'H' then 'Heart'
    when 'D' then 'Diamond'
    when 'S' then 'Spade'
    when 'C' then 'Club'
    end
  end
end



class Game
  def initialize
    @deck = Deck.new
    @human = Player.new
    @dealer = Dealer.new
  end

  def welcome_message
    puts "Welcome to Twenty-One!"
  end

  def deal_cards
    2.times do
      @deck.deal(@human)
      @deck.deal(@dealer)
    end
  end

  def show_initial_cards
    puts "Dealer has: #{@dealer.cards[0].face} and an unknown card."
    puts "You have: #{@human.cards[0].face} and #{@human.cards[1].face}"
    puts ""
  end

  def player_turn
    answer = nil
    loop do
      puts "Would you like to hit or stay? (h for hit, s for stay)"
      answer = gets.chomp.downcase!
      break if [h, s].include? answer
      puts "Sorry, invalid choice."
    end

    player_choice(answer)
  end

  def player_choice(answer)
    case answer
    when 'h'
      @deck.deal(@human)
    when 's'
      puts "Player stayed."
      break
    end

  def total_cards

  end

  def busted?
    @human.total_cards > 21
  end

  def start
    welcome_message
    deal_cards
    show_initial_cards
    player_turn
    break if busted?
    #dealer_turn
    #show_result
  end
end

Game.new.start
