# 1.)

# class Machine

#   def start
#     flip_switch(:on)
#   end

#   def stop
#     flip_switch(:off)
#   end

#   private

#   def flip_switch(desired_state)
#     self.switch = desired_state
#   end

#   attr_writer :switch
# end

# 2.)

# class FixedArray

#   def initialize(length)
#     @length = length
#     @array = [nil] * @length
#   end

#   def []=(index, value)
#     @array[index] = value
#   end

#   def [](index)
#     @array.fetch(index)
#   end

#   def to_a
#     @array.clone
#   end

#   def to_s
#     "#{to_a}"
#   end
# end

# 3.)

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name,year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super
  end
end

# 4.)

class CircularQueue
  def initialize(n)
    @num = n
    @queue = [nil]
  end

  def enqueue(n)
    if size == @num
      dequeue
    end
    @queue << n
  end

  def dequeue
    @queue.shift
  end

  private

  def size
    @queue.size
  end
end

# 5.)
require 'pry'
class Minilang
  def initialize(operations)
    @operations = operations.split(" ")
    @register = 0
    @stack = []
  end

  def eval
    @operations.each do |op|
      case op
      when "PUSH" then push
      when "ADD" then add
      when "SUB" then subt
      when "MULT" then mult
      when "DIV" then div
      when "MOD" then mod
      when "POP" then pop
      when "PRINT" then output
      else place(op)
      end
    end
  end

  def place(num)
    @register = num.to_i
  end

  def output
    puts @register
  end

  def pop
    @regsiter = @stack.pop
  end

  def mod
    @register = @register % @stack.pop
  end

  def div
    @register = @register / @stack.pop
  end

  def mult
    @register = @register * @stack.pop
  end

  def subt
    @register = @register - @stack.pop
  end

  def add
    @register = @register + @stack.pop
  end

  def push
    @stack << @register
  end
end

# 6.)

class PingGame
  def play
    number_of_guesses = 7
    number = rand(1..100)

    loop do
      puts "You have #{number_of_guesses} remaining."
      print "Enter a number between 1 and 100: "
      guess = gets.chomp.to_i
      if won?(number, guess)
        puts "You win!"
        break
      end

      number_of_guesses -= 1
      evaluate_guess(number, guess)
      if number_of_guesses == 0
        puts "You are out of guesses. You lose"
        break
      end
    end
  end

  def won?(number, guess)
    number == guess
  end


  def evaluate_guess(number, guess)
    if guess > number
      puts "Your guess is too high"
    else
      puts "Your guess is too low"
    end
  end
end


# 7.)
require 'pry'
class Guesser
  MESSAGES = { won: "You win!",
               lose: "You ran out of guesses. You lost",
               high: "Your guess is too high",
               low: "You guess is too low"}.freeze

  def initialize(min, max)
    @min = min
    @max = max
    @number_of_guesses = Math.log2(@max-@min).to_i + 1
  end

  def play
    reset
    @number_of_guesses.downto(1) do |num|
      puts "You have #{num} guesses remaining."
      print "Enter a number between #{@min} and #{@max}: "
      guess = gets.chomp.to_i
      result = evaluate_result(guess, @secret_number)
      display_result(result)
      return if result == :won
    end

    puts MESSAGES[:lose]
  end

  def evaluate_result(guess, number)
    if guess > number
      :high
    elsif guess < number
      :low
    else
      :won
    end
  end

  def display_result(result)
    puts MESSAGES[result]
  end

  def reset
    @secret_number = rand(@min..@max)
  end
end

# 8.)

class Card
  include Comparable

  RANK_VALUE = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    RANK_VALUE.index(@rank)
  end

  def <=>(other)
    value <=> other.value
  end
end

# 9.)

class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @deck = []
    initialize_deck
  end

  def initialize_deck
    SUITS.each do |suit|
      RANKS.each do |rank|
        @deck << Card.new(rank, suit)
      end
    end

    @deck.shuffle!
  end

  def draw
    initialize_deck if @deck.size == 0
    @deck.pop
  end
end

# 10.)
require 'pry'
class PokerHand
  def initialize(cards)
    @hand = cards
    @rank_count = Hash.new(0)
    @suit_count = Hash.new(0)

    @hand.each do |card|
      @rank_count[card.rank] += 1
      @suit_count[card.suit] += 1
    end
  end

  def print
    @hand.each { |card| puts card }
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    flush? && @hand.min.value == 8
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    @rank_count.values.include?(4)
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    @suit_count.values.include?(5)
  end

  def straight?
    return false if @rank_count.values.any? { |count| count > 1 }
    @hand.min.value + 4 == @hand.max.value
  end

  def three_of_a_kind?
    @rank_count.values.include?(3)
  end

  def two_pair?
    @rank_count.values.select { |count| count == 2 }.size == 2
  end

  def pair?
    @rank_count.values.include?(2)
  end
end



hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate

