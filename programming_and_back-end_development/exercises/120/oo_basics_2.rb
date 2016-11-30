# 1.)

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

# 2.)

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(other_name)
    self.name = other_name
  end
end

kitty = Cat.new('Sophie')
kitty.name
kitty.rename('Chloe')
kitty.name

# 3.)

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def identify
    self
  end
end

kitty = Cat.new('Sophie')
p kitty.identify

# 4.)

class Cat
  attr_reader :name

  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

  def initialize(name)
    @name = name
  end

  def personal_greeting
    puts "Hello! My name is #{name}"
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting

# 5.)

class Cat
  @@total = 0

  def initialize
    @@total += 1
  end

  def self.total
    puts @@total
  end
end

# 6.)

class Cat
  COLOR = "green"

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hi! I'm #{name} and I'm a #{COLOR}"
  end
end

# 7.)

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    puts "I'm #{name}!"
  end
end

# 8.)

class Person
  attr_accessor :secret
end

# 9.)

class Person
  attr_writer :secret

  def share_secret
    puts secret
  end

  private

  attr_reader :secret
end

# 10.)

class Person
  attr_writer :secret

  def compare_secret(other_person)
    secret == other_person.secret
  end

  protected

  attr_reader :secret
end
