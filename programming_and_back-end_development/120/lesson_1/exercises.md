#### 1.) How do we create an object in Ruby? Give an example of the creation of an object.
Objects are created in Ruby by instantiating an existing class or user-defined class.

```ruby
class MyClass
end

sc = MyClass.new
``` 

#### 2.) What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.
Modules contain methods that can be used by classes through mix-ins.

```ruby
module Launch
end

class MyClass
  include Launch
end

sc = MyClass.new
```

#### Classes and Objects 1

```ruby
class MyCar
  attr_accessor :color
  attr_reader :year
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end
  
  def speed
    @speed
  end
    
  def speed_up
    @speed += 10
    puts "You are now running at #{speed} kph."
  end
  
  def brake
    @speed -= 10
    puts "You are now running at #{speed} kph."
  end
  
  def shut_the_car
    @speed = 0
    puts "Car's now shut off."
  end
  
  def spray_paint(color)
    self.color = color
  end
end
```

#### Classes and Object 2

```ruby
class MyCar
  attr_accessor :color
  attr_reader :year
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end
  
  def to_s
    "This is a #{color} #{year} #{model}"
  end
  
  def self.mileage(l, km)
    "#{km/l} km per liter"
  end
  
  def speed
    @speed
  end
    
  def speed_up
    @speed += 10
    puts "You are now running at #{speed} kph."
  end
  
  def brake
    @speed -= 10
    puts "You are now running at #{speed} kph."
  end
  
  def shut_the_car
    @speed = 0
    puts "Car's now shut off."
  end
  
  def spray_paint(color)
    self.color = color
  end
end
```

3.) There was an error becuase @name only has a getter method. `bob.name = "Bob"` requires a setter method in place.

#### Inheritance

1.) - 3.)
```
module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  @@number_of_vehicles = 0
  attr_accessor :color
  attr_reader :year, :model
  
  def initialize(color, year, model)
    @color = color
    @year = year
    @model = model
    @speed = 0
    @number_of_vehicles += 1
  end
  
  def self.number_of_vehicles
    @@number_of_vehicles
  end
  
  def self.mileage(l, km)
    "#{km/l} km per liter"
  end
end

class MyCar < Vehicle
  	DOORS = 4
end

class MyTruck < Vehicle
  DOORS = 2
  
  include Towable
end
```

4.) 
```ruby
p Vehicle.ancestors
p MyCar.ancestors
p MyTruck.ancestors
```

5.) - 6.)
```
module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  @@number_of_vehicles = 0
  attr_accessor :color
  attr_reader :year, :model
  
  def initialize(color, year, model)
    @color = color
    @year = year
    @model = model
    @speed = 0
    @number_of_vehicles += 1
  end
  
  def self.number_of_vehicles
    @@number_of_vehicles
  end
  
  def self.mileage(l, km)
    "#{km/l} km per liter"
  end
  
  def to_s
    "This is a #{color} #{year} #{model}"
  end
  
  def speed
    @speed
  end
    
  def speed_up
    @speed += 10
    puts "You are now running at #{speed} kph."
  end
  
  def brake
    @speed -= 10
    puts "You are now running at #{speed} kph."
  end
  
  def shut_the_car
    @speed = 0
    puts "Car's now shut off."
  end
  
  def spray_paint(color)
    self.color = color
  end
  
  def age
    "The vehicle is #{years_old} old."
  private
  
  def years_old
    Time.now.year - self.year
  end
    
end

class MyCar < Vehicle
  	DOORS = 4
end

class MyTruck < Vehicle
  DOORS = 2
  
  include Towable
end
```

7.)
```
class Students
  attr_accessor :name
  attr_writer :grade
  
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(other)
    grade > other.grade
  
  protected
  
  def grade
    @grade
  end
end
```

8.) `Hi` method is private. The solution would be to make it public.