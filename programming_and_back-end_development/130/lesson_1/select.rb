# Write a select method that mirrors the behavior of Array#select.

def select(array)
  counter = 0
  acc = []

  while counter < array.size
    current_element = array[counter]
    acc << current_element if !!yield(current_element)

    counter += 1
  end
  acc
end
