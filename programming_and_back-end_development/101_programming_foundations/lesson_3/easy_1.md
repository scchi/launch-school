### Exercises: Easy 1 ###

#####Question 1

**What would you expect the code below to print out?**

```
numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers
```
The code will print out `[1, 2, 2, 3]`. The object receiving the `uniq` method is not changed as opposed to using `uniq!`. `numbers.uniq` simply returns a new array containing the same elements as the original objec but with duplicates removed.

#####Question 2

**Describe the difference between `!` and `?` in Ruby, and explain what would happen in the following scenarios:**

1. what is `!=` and where should you use it?
2. put `!` before something, like `!user_name`
3. put `!` after something, like `words.uniq!`
4. put `?` before something
5. put `?` after something
6. put `!!` before something like `!!7. user_name`

These are commonly seen in Ruby methods where a `!` after a method means it will mutate the object. This is also used to negate the truth value of an object. `?`, on the other hand, is often seen in Boolean methods where value returned is either `true` or `false`

`!=` is a Boolean operator where it returns `true` if the objects being compared are not the same. 

Putting a `!` before something negates the truth value of the object. 

`!` after a method means that the object receiver of the method or the caller of the method will be changed or mutated.

Putting `?` before a single character returns the character code.

`?` before something is usually a method where the return value is a Boolean.

`!!` is double negation.

#####Question 3

** Replace the word "important" with "urgent"" in this string:**

```
advice = "Few things in life are as important as house training your pet dinosaur."
```
```
advice.gsub!('important', 'urgent')
```

#####Question 4

** The Ruby Array class has several methods for removing items from the array. Two of them have very similar names. Let's see how they differ:**

```
numbers = [1, 2, 3, 4, 5]
```

**What does the following method calls do (assume we reset `numbers` to the original array between method calls)?**

```
numbers.delete_at(1)

numbers.delete(1)
```
The `delete_at(1)` method removes and returns the element at index 1. In this case, 2 is removed from `numbers` array and is returned.

`delete(1)`, on the other hand, removes the element 1 in the array and returns it.

#####Question 5

**Programmatically determine if 42 lies between 10 and 100.**

```
(10..100).include?(42)
```

#####Question 6

**Starting with the string:**

```
famous_words = "seven years ago..."
```
**show two different ways to put the expected "Four score and " in front of it.**

```
"Four score and " + famous_words
famous_words.prepend("Four score and ")
```

#####Question 7

**Fun with gsub:**

```
def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)")

p how_deep
```

**This gives us a string that looks like a "recursive" method call:**

```
add_eight(add_eight(add_eight(add_eight(add_eight(number)))))
```
**If we take advantage of Ruby's `Kernel#eval` method to have it execute this string as if it were a "recursive" method call**

```
eval(how_deep)
```

**what will be the result?**

42

#####Question 8

**If we built an array like this:**

```
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
```

**We will end up with this "nested" array:**

```
["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]
```

**Make this into an un-nested array.**

`flintstones.flatten!`

#####Question 9

**Given the hash below**

```
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5}
```

**Turn this into an array containing only two elements: Barney's name and Barney's number.**

`flintstones.assoc("Barney")`

#####Question 10

**Given the array below**

```
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
```

**Turn this array into a hash where the names are the keys and the values are the positions in the array.**

```
flintstones_hash
flintstones.each_with_index { |value, index| flintstones_hash[value] = index }
```

