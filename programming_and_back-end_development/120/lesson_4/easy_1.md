#### 1.) Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

```
true
"hello"
[1, 2, 3, "happy days"]
142
```
---
They are all objects. To find out what class an object belongs to, use the `class` method. For example, `true.class` returns `TrueClass`.

--
#### 2.) If we have a Car class and a Truck class and we want to be able to go_fast, how can we add the ability for them to go_fast using the module Speed? How can you check if your Car or Truck can now go fast?

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
```
---
By mixing in the Speed module (`include Speed`), Cars and Trucks will now have access to the `go_fast` method. 

```
car = Car.new
car.go_fast # => "I am a Car and going super fast!"

truck = Truck.new
car.go_fast # => "I am a truck and going super fast!"

```
--
#### 3.) In the last question we had a module called Speed which contained a go_fast method. We included this module in the Car class as shown below.

```
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end
```
#### When we called the go_fast method from an instance of the Car class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?

```
>> small_car = Car.new
>> small_car.go_fast
I am a Car and going super fast!
```
---
There's a string interpolation of `self.class` in the definition of `go_fast` method. When `small_car.go_fast` is executed, self is small_car. Thus, `self.class` evaluates to Car.

--
#### 4.) If we have a class AngryCat how do we create a new instance of this class?

#### The AngryCat class might look something like this:

```
class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end 
```
---
`tom = AngryCat.new`

--
#### 5.) Which of these two classes has an instance variable and how do you know?

```
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end
```
---
Only Pizza has an instance variable. Instance variables start with @. 

--
#### 6.) What could we add to the class below to access the instance variable @volume?

```
class Cube
  def initialize(volume)
    @volume = volume
  end
end
```
---
`attr_getter`
or
```
def volume
  @volume
end
```

--
#### 7.) What is the default thing that Ruby will print to the screen if you call to_s on an object? Where could you go to find out if you want to be sure?
---
Ruby prints out the string representation of an object, which is the Ruby class and a series of numbers that represent the object's id.

--
#### 8.) If we have a class such as the one below:

```
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
```
#### You can see in the make_one_year_older method we have used self. What does self refer to here?
---
`self` refers to the Cat instance that called the method.

--
#### 9.) If we have a class such as the one below:

```
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
```
#### In the name of the cats_count method we have used self. What does self refer to in this context?
---
`self` refers to the Cat class. `cats_count`, therefore is a class method.

--
#### 10.) If we have the class below, what would you need to call to create a new instance of this class.

```
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end
```
---
`jansport = Bag.new('red', 'leather')`
The initialize method expects two arguments to be passed in when creating a new instance.