# 1.)

class Person
  attr_accessor :name
end

#2.)

class Person
  attr_accessor :name
  attr_writer :phone_number
end

# 3.)

class Person
  attr_reader :phone_number

  def initialize(number)
    @phone_number = number
  end
end

# 4.)

class Person
  attr_accessor :first_name
  attr_writer :last_name

  def first_equals_last?
    first_name == last_name
  end

  private

  attr_reader :last_name
end

# 5.)

class Person
  attr_writer :age

  def older_than?(other)
    age > other.age
  end

  protected

  attr_reader :age
end

# 6.)

class Person
  attr_reader :name

  def name=(new_name)
    @name = new_name.capitalize
  end
end

# 7.)

class Person
  attr_writer :name

  def name
    "Mr. #{@name}"
  end
end

# 8.)

class Person
  def initialize(name)
    @name = name
  end

  def name
    @name.clone
  end
end

# 9.)

class Person
  def age=(age)
    @age = age * 2
  end

  def age
    @age * 2
  end
end

# 10.)

class Person
  def name=(name)
    @first_name, @last_name = name.split(' ')
  end

  def name
    "#{@first_name} #{@last_name}"
  end
end
end
