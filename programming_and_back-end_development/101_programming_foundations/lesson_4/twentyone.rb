SUITS = ['C', 'H', 'S', 'D']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

def prompt(msg)
  puts "=> #{msg}"
end

def init_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  total = 0
  card_values = cards.map { |card| card[1] }

  card_values.each do |value|
    if value == 'A'
      total += 11
		elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end
  end

  card_values.count('A').times { total -= 10 if total > 21 }
  total
end

def busted?(cards)
  total(cards) > 21
end

def detect_result(player, dealer)
  player_score = total(player)
  dealer_score = total(dealer)

  if player_score > 21
    :player_busted
  elsif dealer_score > 21
    :dealer_busted
  elsif player_score > dealer_score
    :player_won
  elsif dealer_score > player_score
    :dealer_won
  else
    :tie
  end
end

def display_result(player, dealer)
  result = detect_result(player, dealer)

  case result
  when :player_busted
    prompt("Player got busted!")
  when :dealer_busted
    prompt("Dealer got busted!")
  when :player_won
    prompt("Player won!")
  when :dealer_won
    prompt("Dealer won!")
  when :tie
    prompt("It's a tie!")
  end
end

def play_again?
  prompt("Would you like to play again?")
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

prompt("Welcome to Twenty One")

loop do
  system 'clear'
  deck = init_deck
  player_cards = []
  dealer_cards = []

  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end

  prompt("Dealer has #{dealer_cards[0]} and one other card.")
  prompt("You have #{player_cards[0]} and #{player_cards[1]}.")

  loop do
    player_turn = ''

    loop do
      prompt("Hit or Stay?")
      player_turn = gets.chomp
      break if player_turn == 'h' || player_turn == 's'
    end

    if player_turn == 'h'
      prompt("You chose to hit.")
      player_cards << deck.pop
      prompt("Your cards are #{player_cards}.")
      prompt("Your total is now: #{total(player_cards)}")
    end

    break if player_turn == 's' || busted?(player_cards)
  end

  if busted?(player_cards)
    display_result(player_cards, dealer_cards)
    play_again? ? next : break
  else
    prompt("You stayed.")
  end

  prompt("Dealer's turn")

  loop do
    break if busted?(dealer_cards) || total(dealer_cards) >= 17
    prompt("Dealer chose to hit.")
    dealer_cards << deck.pop
    prompt("Dealer's cards are #{dealer_cards}")
    prompt("Dealer total is now: #{total(dealer_cards)}")
    system 'clear'
  end

  if busted?(dealer_cards)
    display_result(player_cards, dealer_cards)
    play_again? ? next : break
  else
    prompt("Dealer stayed.")
    prompt("Dealer's cards are #{dealer_cards}")
  end

  prompt("------------------------------------------")
  prompt("You have a total of #{total(player_cards)}")
  prompt("Dealer has a total of #{total(dealer_cards)}")

  display_result(player_cards, dealer_cards)
  break unless play_again?
end
