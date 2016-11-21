### Exercises: Easy 2 ###

##### Question 1

** In this hash of people and their age, **

```
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
```
** see if there is an age present for "Spot" **

** Bonus: What are two other hash methods that would work just as well for this solution? **

___

```
ages.key("Spot")
ages.include?("Spot")
ages.has_key?("Spot")
```

##### Question 2

** Add up all of the ages from our current Munster family hash: **

```
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
```
---
```
ages.values.inject(:+)
```

##### Question 3

** In the age hash: **

```
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
```
** throw out the really old people (age 100 or older). **
___
```
ages.delete_if { |k, v| key >=  100 }
```

##### Question 4

** Starting with this string: **

```
munsters_description = "The Munsters are creepy in a good way."
```
** Convert the string in the following ways (code will be executed on original `munsters_description` above): **

```
"The munsters are creepy in a good way."
"tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
"the munsters are creepy in a good way."
"THE MUNSTERS ARE CREEPY IN A GOOD WAY."
```
___
```
munsters_description.capitalize!
munsters_description.swapcase!
munsters_description.downcase!
munsters_description.upcase!
```
##### Question 5

** We have most of the Munster family in our age hash: **

```
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
```
** add ages for Marilyn and Spot to the existing hash **

```
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
```
___
```
ages.merge!(additional_ages)
```
##### Question 6

** Pick out the minimum age from our current Munster family hash: **

```
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
```
___
```
ages.values.min
```
##### Question 7

** See if the name "Dino" appears in the string below: **

```
advice = "Few things in life are as important as house training your pet dinosaur."
```
___
```
advice.match("Dino")
```
##### Question 8

** In the array: **

```
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
```
** Find the index of the first name that starts with "Be" **
___
```
flintstones.index { |value| value.start_with?("Be")
```

##### Question 9

** Using `array#map!`, shorten each of these names to just 3 characters: **

```
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
```
___
```
flintstones.map! do |value|
  value[0, 3]
end
```
##### Question 10

** After, shorten each of these names to just 3 characters -- but this time do it all on one line: **

```
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
```
___
```
flintstones.map! { |value| value[0, 3] }
```