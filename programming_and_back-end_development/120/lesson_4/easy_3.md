#### 1.) If we have this code:
```
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```
#### What happens in each of the following cases:

####case 1:
```
hello = Hello.new
hello.hi
```
####case 2:
```
hello = Hello.new
hello.bye
```
####case 3:
```
hello = Hello.new
hello.greet
```
#### case 4:
```
hello = Hello.new
hello.greet("Goodbye")
```
#### case 5:
`Hello.hi`

---
CASE 1

`"Hello"`

CASE 2

`NoMethodError`

bye method is only available to `Goodbye` class

CASE 3

`ArgumentError`

The greet method is available to `Hello` class but the method expects an argument. None is provided in the call.

CASE 4

`"Goodbye"`

CASE 5

Ruby will raise an error becuase the `hi` method is an instance method. Classes can't call instance methods.

--

#### 2.) In the last question we had the following classes:

```
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```
#### If we call Hello.hi we get an error message. How would you fix this?
---

A way to fix this is to implement a `hi` class method.

```
def self.hi
  puts "Hi from the Hello class"
end
```

--
#### 3.) When objects are created they are a separate realization of a particular class.

#### Given the class below, how do we create two different instances of this class, both with separate names and ages?

```
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end
```

---
```
cat1 = AngryCat.new(12, "Tom")
cat2 = AngryCat.new(2, "Tim")
```

--
#### 4.) Given the class below, if we created a new instance of the class and then called to_s on that instance we would get something like "#<Cat:0x007ff39b356d30>"
```
class Cat
  def initialize(type)
    @type = type
  end
end
```
#### How could we go about changing the to_s output on this method to look like this: I am a tabby cat? (this is assuming that "tabby" is the type we passed in during initialization).
---
```
def to_s
  puts "I am a #{type} cat."
end
```

--
#### 5.) If I have the following class:
```
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
```
#### What would happen if I called the methods like shown below?
```
tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model
```
---
`tv.manufacturer` would raise an error as instances can't call the class method `manufacturer`

`tv.model` will run whatever method logic is inside

`Television.manufacturer` will run the method logic ug class method `manufacturer`

`Television.model` will raise an error as classes cannot  access instance methods.

--
#### 6.) If we have a class such as the one below:
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
#### In the make_one_year_older method we have used self. What is another way we could write this method so we don't have to use the self prefix?
---
```
def make_one_year_older
  @age += 1
end
```

--
#### 7.) What is used in this class but doesn't add any value?
```
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end
```
---
The `return` in the `information` method doesn't add any value. Methods return whatever the last expression evaluates to so there's no need for the `return`.
