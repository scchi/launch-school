def prompt(message)
	puts "=> #{message}"
end

def valid_amount?(amount)
	/^\d*\.?\d*$/.match(amount)
end

def valid_integer?(num)
	/^\d+$/.match(num)
end

def normalize(duration, rate)
	duration = duration.to_i * 12
	rate = rate.to_f / 120
	return duration, rate
end

def monthly_payment(principal, duration, rate)
	months, interest = normalize(duration, rate)
	principal.to_f * ((interest * ((1 + interest)**months)) / (((1 + interest)**months) - 1))
end

prompt("Welcome to Mortgage Calculator!")


loop do
	principal = ''
	loop do
		prompt("Please enter the loan amount:")
		principal = gets.chomp()

		break if valid_amount?(principal)
		prompt("Please enter a valid a loan amount.")
	end

	duration = ''
	loop do
		prompt("Please enter the loan duration in years:")
		duration = gets.chomp()

		break if valid_integer?(duration)
		prompt('Please enter a valid number.')
	end

	rate = ''
	loop do
		prompt("Please enter the annual interest rate in percent without the percent sign. (5 for 5%, 2.3 for 2.3%")
		rate = gets.chomp()

		break if valid_amount?(rate)
		prompt("Please enter a valid interest rate.")
	end

	prompt("Monthly payment is $#{monthly_payment(principal, duration, rate).round(2)}")

	prompt("Would you like to do another calculation? (Y for yes)")
	answer = gets.chomp()

	break unless answer.downcase.start_with?('y')
end

prompt("Thank you for using Mortgage Calculator!")