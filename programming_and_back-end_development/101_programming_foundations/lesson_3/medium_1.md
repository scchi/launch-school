### Exercises: Medium 1

##### Question 1

** Let's do some "ASCII Art" (a stone-age form of nerd artwork from back in the days before computers had video screens). **

** For this exercise, write a one-line program that creates the following output 10 times, with the subsequent line indented 1 space to the right: **

```
The Flintstones Rock!
 The Flintstones Rock!
  The Flintstones Rock!
  ```
___
```
10.times { |space| puts "#{" " * space}The Flintstones Rock!" }
```
##### Question 2

** Create a hash that expresses the frequency with which each letter occurs in this string: **

```
statement = "The Flintstones Rock"
{ "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }
```
___
```
letter_hash = {}
statement.split('').uniq.each { |letter| letter_hash[letter] = statement.count(letter) }
```
##### Question 3

** The result of the following statement will be an error: **

```
puts "the value of 40 + 2 is " + (40 + 2)
```
** Why is this and what are two possible ways to fix this? **
___
The code above will return an error becuase String and Fixnum can't be concatenated.

```
puts "the value of 40 + 2 is #{40 + 2}"
puts "the value of 40 + 2 is " + (40 + 2).to_s
```
##### Question 4
** What happens when we modify an array while we are iterating over it? What would be output by this code? **
```
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end
```
** What would be output by this code? **
```
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end
```
___
```
1
3
```
```
1
2
```
##### Question 5
** Alan wrote the following method, which was intended to show all of the factors of the input number: **

```
def factors(number)
  dividend = number
  divisors = []
  begin
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end until dividend == 0
  divisors
end
```

** Alyssa noticed that this will fail if you call this with an input of `0` or a negative number and asked Alan to change the loop. How can you change the loop construct (instead of using begin/end/until) to make this work? Note that we're not looking to find the factors for 0 or negative numbers, but we just want to handle it gracefully instead of raising an exception or going into an infinite loop. **

** Bonus 1 **

** What is the purpose of the `number % dividend == 0`?

** Bonus 2 **

** What is the purpose of the second-to-last line in the method (the `divisors` before the method's `end`)? **

___
```
while dividend > 0 do
  divisors << number / dividend if number % dividend == 0
  dividend -= 1
end
```
`number % dividend == 0` allows you to check if division has no remainder.

`divisors` returns the array of divisors to `number`.
##### Question 6

** Alyssa was asked to write an implementation of a rolling buffer. Elements are added to the rolling buffer and if the buffer becomes full, then new elements that are added will displace the oldest elements in the buffer. **

** She wrote two implementations saying, "Take your pick. Do you like `<<` or `+` for modifying the buffer?". Is there a difference between the two, other than what operator she chose to use to add an element to the buffer? **

```
def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end
```
___
The first implementation with `<<` will modify the input array, while `+` won't. Both implementations will return the same array.
##### Question 7

** Alyssa asked Ben to write up a basic implementation of a Fibonacci calculator. A user passes in two numbers, and the calculator will keep computing the sequence until some limit is reached. **

** Ben coded up this implementation but complained that as soon as he ran it, he got an error. Something about the limit variable. What's wrong with the code? **

```
limit = 15

def fib(first_num, second_num)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"
```
** How would you fix this so that it works? **
___
`limit` variable, having been declared outside the method, isn't visible inside `fib`. This can be fixed by passing in `limit` to the method's arguments or by declaring it inside the method.
##### Question 8

** In another example, we used some built-in string methods to change the case of a string. A notably missing method is something provided in Rails, but not in Ruby itself...`titleize`! This method in Ruby on Rails creates a string that has each word capitalized as it would be in a title. **

** Write your own version of the rails `titleize` implementation. **

___
```
def titleize(title)
  title.split.map { |word| word.capitalize }.join(' ')
end
```
##### Question 9

** Given the `munsters` hash below **

```
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
```
** Modify the hash such that each member of the Munster family has an additional "age_group" key that has one of three values describing the age group the family member is in (kid, adult, or senior). Your solution should produce the hash below **

```
{ "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
  "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
  "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
  "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
  "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" } }
  ```
  
  ** Note: a kid is in the range 0 - 17, an adult is in the range 18 - 64, and a senior is aged 65+ **
  ___
  ```
  munsters.each do |name, info|
    case info["age"]
    when 0..17
      info["age_group"] = "kid"
    when 18..64
      info["age_group"] = "adult"
    else
      info["age_group"] = "senior"
    end
  end
  ```