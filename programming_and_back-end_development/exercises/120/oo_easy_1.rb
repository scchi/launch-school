# 1.)

class Banner
  def initialize(message)
    @message = message
    @width = message.size
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def fill_space(char)
    char * (@width + 2)
  end

  def horizontal_rule
    puts "+#{fill_space("-")}+"
  end

  def empty_line
    puts "|#{fill_space(" ")}|"
  end

  def message_line
    puts "| #{@message} |"
  end
end

# 2.)

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

# 3.)

class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

# 4.)

class Book
  attr_accessor :author, :title

  def to_s
    %("#{title}", by #{author})
  end
end

# 5.)

class Person
  attr_writer :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end

  def first_name=(value)
    @first_name = value.capitalize
  end

  def last_name=(value)
    @last_name = value.capitalize
  end
end

# 6.)

class Flight
  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# 7.)

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    self.mileage += miles
  end

  def print_mileage
    puts mileage
  end
end

# 8.)

class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square
  def initialize(side_length)
    super(side_length, side_length)
  end
end

# 9.)

class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "My cat #{@name} is #{@age} years old and has #{@color} fur."
  end
end

# 10.)
class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

