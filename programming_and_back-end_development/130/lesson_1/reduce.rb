# Implement a reduce method, similar to Enumerable#reduce.

def my_reduce(array, start_value = 0)
  counter = 0

  result = start_value
  while counter < array.size
    result = yield(array[counter], result)
    counter += 1
  end

  result
end
