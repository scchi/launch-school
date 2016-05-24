VALID_CHOICES = {r: 'rock', p: 'paper', sc: 'scissors', sp: 'spock', l: 'lizard'}

def prompt(message)
	Kernel.puts("=> #{message}")
end

def win?(first, second)
	(first == 'rock' && second == 'scissors') || (first == 'rock' && second == 'lizard') ||
	(first == 'paper' && second == 'rock') || (first == 'paper' && second == 'spock') ||
	(first == 'scissors' && second == 'paper') || (first == 'scissors' && second == 'lizard') ||
	(first == 'spock' && second == 'rock') || (first == 'spock' && second == 'scissors') ||
	(first == 'lizard' && second == 'spock') || (first == 'lizard' && second == 'paper')
end

def display_result(player, computer)
	if win?(player, computer)
		prompt("You won!")
	elsif win?(computer, player)
		prompt ("Computer won!")
	else
		prompt("It's a tie!")
	end
end

def update_score(player, player_score, computer, computer_score)
	if win?(player, computer)
		player_score += 1
	elsif win?(computer, player)
		computer_score += 1
	end
	return player_score, computer_score
end

def display_winner(player, computer)
	if player == 5
		prompt("You've reached five points! You won!")
	else
		prompt("The computer beat you to five points.")
	end
end

prompt("Welcome to Rock, Paper, Scissors, Spock, Lizard")
prompt("-----------------------------------------------\n\n")

loop do
	player_score, computer_score = 0, 0
  loop do
		choice = ''
		loop do
			prompt("Choose one:")
			VALID_CHOICES.each { |k, v| puts "\t\t#{k} for #{v}" }
			choice = Kernel.gets().chomp()

			if VALID_CHOICES.keys.include?(choice.to_sym)
				choice = VALID_CHOICES[choice.to_sym]
				break
			end
			prompt("That's not a valid choice.")
		end

		computer_choice = VALID_CHOICES.values.sample()

		prompt("You chose: #{choice}. Computer chose: #{computer_choice}.")

		display_result(choice, computer_choice)
	  player_score, computer_score = update_score(choice, player_score, computer_choice, computer_score)
	  prompt("Player: #{player_score}. Computer: #{computer_score}.")
	  puts
    break if player_score == 5 || computer_score == 5			
  end
  
  display_winner(player_score, computer_score)

	prompt("Do you want to play again?")
	answer = Kernel.gets().chomp() 
	system "clear"
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing!")