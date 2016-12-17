# # 1.)

# class Customer
#   include Mailable
#   attr_reader :name, :address, :city, :state, :zipcode
# end

# class Employee
#   include Mailable
#   attr_reader :name, :address, :city, :state, :zipcode
# end

# # 2.)

# module Drivable
#   def drive
#   end
# end

# class Car
#   include Drivable
# end

# # 3.)

# class House
#   attr_reader :price

#   def initialize(price)
#     @price = price
#   end

#   def <=>(other)
#     price <=> other.price
#   end
# end

# # 4.)

# class Transform
#   attr_reader :data

#   def self.lowercase(str)
#     str.downcase
#   end

#   def initialize(data)
#     @data = data
#   end

#   def uppercase
#     @data.uppercase
#   end
# end

# # 5.)

# "ByeBye"
# "HelloHello"

# # 6.)

# class Wallet

#   protected

#   attr_reader :amount
# end

# 7.)
require 'pry'
class Pet
  attr_reader :name, :type

  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{type} named #{name}"
  end
end

class Owner
  attr_reader :name
  attr_accessor :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def number_of_pets
    pets.size
  end

  def print_pets
    pets.each { |pet| puts pet}
  end
end

class Shelter
  def initialize
    @owners = {}
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
  end

  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end
end

# 8.)

class Expander
  def to_s
    expand(3)
  end
end

# 9.)

module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

# 10.)

module Walkable
  def walk
    "#{self} #{gait} forward"
  end
end

class Noble
  attr_reader :name, :title

  include Walkable

  def initialize(name, title)
    @name = name
    @title = title
  end

  def to_s
    "#{title} #{name}"
  end

  private

  def gait
    "struts"
  end
end


