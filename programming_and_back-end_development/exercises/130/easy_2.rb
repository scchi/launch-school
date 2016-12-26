# 1.)

def step(start, ending, inc)
  num = start
  loop do
    yield(num)
    break if num + inc > ending
    num += inc
  end
  num
end

# 2.)

def zip(array1, array2)
  result = []
  (0...array1.size).each { |index| result << [array1[index], array2[index]]}
  result
end

# 3.)

def map(ary)
  ary.each.with_object([]) { |el, result| result << yield(el) }
end

# 4.)

def count(*collection)
  result = 0
  collection.each { |item| result += 1 if yield(item) }
  result
end

# 5.)

def drop_while(ary)
  ary.each_with_object([]) { |el, result| result << el unless yield(el) }
end

# 6.)

def each_with_index(ary)
  index = 0
  while index <= ary.size - 1
    yield(ary[index], index)
    index += 1
  end
  ary
end

# 7.)

def each_with_object(ary, obj)
  index = 0
  object = obj
  while index <= ary.size - 1
    yield(ary[index], object)
    index += 1
  end
  object
 end

# 8.)

def max_by(ary)
  result = []
  ary.each { |x| result << yield(x) }

  max = result[0]
  for i in result[1..-1]
    max = i if i > max
  end
  ary[result.index(max)]
end

# 9.)

def each_cons(ary)
  index = 0

  while index < ary.size - 1
    yield(ary[index], ary[index + 1])
    index += 1
  end
end

# 10.)

def each_cons(ary, n)
  index = 0

  while index <= ary.size - n
    yield(*ary[index,n])
    index += 1
  end
end
