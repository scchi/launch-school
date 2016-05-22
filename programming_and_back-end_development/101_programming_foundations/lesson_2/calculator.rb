require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
	Kernel.puts("=> #{message}")
end

def valid_number?(num)
	/^\d+\.?\d*$/.match(num)
end

def operation_to_message(op)
	choice = case op
						 when '1'
					     'Adding'
						 when '2'
							 'Subtracting'
						 when '3'
							 'Multiplying'
						 when '4'
							 'Dividing'
						 end
	choice
end

prompt(MESSAGES['welcome'])

name = ''
loop do
	name = Kernel.gets().chomp()

	if name.empty?()
		prompt(MESSAGES['valid_name'])
	else
		break
	end
end

prompt(eval(%Q["#{MESSAGES['greet']}"]))

loop do
	number1 = ''
	loop do
	  prompt(MESSAGES['first_number'])
	  number1 = Kernel.gets().chomp()

	  break if valid_number?(number1)
	  prompt(MESSAGES['valid_number'])
	end

	number2 = ''
	loop do
	  prompt(MESSAGES['second_number'])
	  number2 = Kernel.gets().chomp()

	  break if valid_number?(number2)
	  prompt(MESSAGES['valid_number'])
	end
  
	prompt(MESSAGES['operator'])
	
	operator = ''
	loop do
	  operator = Kernel.gets().chomp()

	  break if %w(1 2 3 4).include?(operator)
	  prompt(MESSAGES['valid_operator'])
	end

	prompt(eval(%Q["#{MESSAGES['confirmation']}"]))

	result = case operator
					 when '1'
					 	 number1.to_i() + number2.to_i()
					 when '2'
					 	 number1.to_i() - number2.to_i()
					 when '3'
					 	 number1.to_i() * number2.to_i()
					 when '4'
					 	 number1.to_f() / number2.to_f()
	end

	prompt(eval(%Q["#{MESSAGES['result1']}"]))

	prompt(MESSAGES['again'])
	answer = Kernel.gets().chomp()
	break unless answer.downcase().start_with?('y')
end

prompt(MESSAGES['bye'])