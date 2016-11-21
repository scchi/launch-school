#### Given this class:

```ruby
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"
```

#### One problem is that we need to keep track of different breeds of dogs, since they have slightly different behaviors. For example, bulldogs can't swim, but all other dogs can.

#### Create a sub-class from Dog called Bulldog overriding the swim method to return "can't swim!"

```ruby
class Bulldog < Dog
  def swim
    'can't swim!'
  end
end
```

#### Let's create a few more methods for our Dog class.

```ruby
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def fetch
    'fetching!'
  end
end
```

#### Create a new class called Cat, which can do everything a dog can, except swim or fetch. Assume the methods do the exact same thing. Hint: don't just copy and paste all methods in Dog into Cat; try to come up with some class hierarchy.

```ruby
def Animal
  def run
    'running!'
  end
  
  def jump
    'jumping!'
  end
end

def Dog < Animal
  def speak
    'bark!'
  end
  
  def swim
    'swimming!'
  end
  
  def fetch
    'fetching!'
  end
end
  
  class Cat < Animal
    def speak
      'meow!'
    end
  end
```

#### 3.) Draw a class hierarchy diagram of the classes from step
 
                            Animal
                           /      \
                          /        \
                        Dog       Cat
                        /
                       /
                    Bulldog
                    
#### 4.) What is the method lookup path and how is it important?  
Method lookup path is a list of classes and modules where a method is searched in order starting with the class of the object itself and all the way up to, possibly, `BasicObject`. If all classes and modules in the method lookup path has been searched and the method isn't found, and error will be raised.

The `ancestors` method returns the method lookup path in an array.