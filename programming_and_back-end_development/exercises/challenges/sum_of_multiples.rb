require 'pry'

class SumOfMultiples
  def initialize(*numbers)
    @numbers = numbers
  end

  def to(n)
    return 0 if n < @numbers.first
    self.class.to(n, @numbers)
  end

  def self.to(n, numbers = [3, 5])
    return 0 if n < 3
    multiples = []
    numbers.each { |d| multiples.concat(d.step(n-1, d).to_a) }
    multiples.uniq.inject(:+)
  end
end
