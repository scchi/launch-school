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