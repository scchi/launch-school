require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

LANGUAGE = 'de'

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(key, msg = '')
  message = messages(key, LANGUAGE)   
  Kernel.puts("=> #{message}" + msg)
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

prompt('welcome')

name = ''
loop do
	name = Kernel.gets().chomp()

	if name.empty?()
		prompt('valid_name')
	else
		break
	end
end

prompt('greet', "#{name}")

loop do
	number1 = ''
	loop do
	  prompt('first_number')
	  number1 = Kernel.gets().chomp()

	  break if valid_number?(number1)
	  prompt('valid_number')
	end

	number2 = ''
	loop do
	  prompt('second_number')
	  number2 = Kernel.gets().chomp()

	  break if valid_number?(number2)
	  prompt('valid_number')
	end
  
	prompt('operator')
	
	operator = ''
	loop do
	  operator = Kernel.gets().chomp()

	  break if %w(1 2 3 4).include?(operator)
	  prompt('valid_operator')
	end

	puts "=> #{operation_to_message(operator)}"

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

	prompt('result1', "#{result}")

	prompt('again')
	answer = Kernel.gets().chomp()
	break unless answer.downcase().start_with?('y')
end

prompt('bye')