# 1.)

class Tree
  include Enumerable

  def each
  end
end

# 2.)

def compute
  block_given? ? yield : "Does not compute."
end

# 3.)

def missing(array)
  (array[0]..array[-1]).to_a - array
end

# 4.)

def divisors(n)
  return [1] if n == 1
  1.upto(n/2).select { |num| n % num == 0 } << n
end

# 5.)

def decrypt(names)
  names.each { |name| puts name.tr('A-Za-z', 'N-ZA-Mn-za-m') }
end

# 6.)

def any?(array)
  array.each { |item| return if yield(item) }
  false
end

# 7.)

def all?(array)
  array.each { |result, item| return false unless yield(item) }
  true
end

# 8.)

def none?(array)
  array.each { |item| return false if yield(item) }
  true
end

# 9.)

def one?(collection)
  seen_one = false
  collection.each do |element|
    next unless yield(element)
    return false if seen_one
    seen_one = true
  end
  seen_one
end

# 10.)

def count(array)
  count = 0
  array.each { |item| count += 1 if yield(item) }
  count
end








