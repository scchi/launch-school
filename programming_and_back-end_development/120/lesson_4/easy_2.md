#### 1.) You are given the following code:

```
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end
```
#### What is the result of calling

```
oracle = Oracle.new
oracle.predict_the_future
```
---
It will output a string concatenation of `"You will"` and one of the elements in the array inside choices. Which element gets picked is random because of the `sample` method.

--
#### 2.) We have an Oracle class and a RoadTrip class that inherits from the Oracle class.

```
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end
```
#### What is the result of the following:

```
trip = RoadTrip.new
trip.predict_the_future
```
---
The same as calling `predict_the_future` method with an Oracle instance but with a different `choices` array. RoadTrip overrides it's parent's `choices` method by defining a `choices` method.

--
#### 3.) How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?

```
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end
```

#### What is the lookup chain for Orange and HotSauce?
---
By using the `ancestors` method, you will get an array of the method lookup. 
```
Orange.ancestors
HotSauce.ancestors
```

--
#### 4.) What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?

```
class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
```
---
```
class BeesWax
  attr_accessor: type
  
  def initialize(type)
    @type = type
  end
  
  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end
```

--
#### 5.) There are a number of variables listed below. What are the different types and how do you know which is which?

```
excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"
```
---
There are the local variables, instance variables, and class variables. If the variable starts with @ or @@, it's an instance variable or class variable respectively. Absence of @ or @@ means that the variable is local.

---
#### 6.) If I have the following class:

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
#### Which one of these is a class method (if any) and how do you know? How would you call a class method?
---
`self.manufacturer` is a class method. Defining a method inside a class with prepended with self. makes a method a class method.

`Television.manufacturer` is how you would call the manufacturer class method.

--
#### 7.) If we have a class such as the one below:

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
#### Explain what the @@cats_count variable does and how it works. What code would you need to write to test your theory?
---
`@@cats_count` is a class variable that increments by 1 everytime a new instance of Cat is created.

```
Cat.cats_count     #=> 0
cat1 = Cat.new("persian")
Cat.cats_count     #=> 1
cat2 = Cat.new("bobtail")
cat3 = Cat.new("bengal")
Cat.cats_count     #=> 3
```

--
#### 8.) If we have this class:

```
class Game
  def play
    "Start the game!"
  end
end
```
And another class:

```
class Bingo
  def rules_of_play
    #rules of play
  end
end
```
#### What can we add to the Bingo class to allow it to inherit the play method from the Game class?
---
`class Bingo < Game`

--
#### 9.) If we have this class:

```
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end
```

#### What would happen if we added a play method to the Bingo class, keeping in mind that there is already a method of this name in the Game class that the Bingo class inherits from.
---
The play method in the Bingo class would override the one defined in the Game class. As a result, all instances of Bingo will execute Bingo's play method.

---
#### 10.) What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.
---
1.) It can help manage complexity in code.
2.) OOP helps avoid duplication.
3.) Code reuse and recycling



