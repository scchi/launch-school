#### 1.) Given the below usage of the Person class, code the class definition.

```ruby
bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'
```
```ruby
class Person
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end
```

#### 2.) Modify the class definition from above to facilitate the following methods. Note that there is no name= setter method now.

```ruby
bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'
```
#### Hint: let first_name and last_name be "states" and create an instance method called name that uses those states.

```ruby
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(name)
    fnln = name.split(' ')
    @first_name = fnln.first
    @last_name = fnln.size > 1 ? fnln[-] : ""
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
end
```

#### 3.) Now create a smart name= method that can take just a first name or a full name, and knows how to set the first_name and last_name appropriately.

```ruby
bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
bob.first_name            # => 'John'
bob.last_name             # => 'Adams'
```

```ruby
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(name)
    fnln = name.split(' ')
    @first_name = fnln.first
    @last_name = fnln.size > 1 ? fnln[-] : ""
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(n)
    fnln = n.split(' ')
    self.first_name = fnln.first
    self.last_name = fnln.size > 1 ? fnln[-] : ""
  end
end
```

#### 4.) Using the class definition from step #3, let's create a few more people -- that is, Person objects.

```ruby
bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
```
#### If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?

`bob.name == rob.name`

#### 5.) Continuing with our Person class definition, what does the below print out?

```ruby
bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
```

This won't print "Robert Smith" as string interpolation called `to_s` on the object `bob`.

#### Let's add a to_s method to the class:

```ruby
class Person
  # ... rest of class omitted for brevity

  def to_s
    name
  end
end
```
#### Now, what does the below output?

```ruby
bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
```

Because the `to_s` method has been overridden, this prints `Robert Smith`
