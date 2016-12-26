class Sieve
  attr_reader :limit

  def initialize(limit)
    @limit = limit
  end

  def primes
    range = (2..limit).to_a
    primes = []

    loop do
      num = range.shift
      range.delete_if { |mul| mul % num == 0 }
      primes << num
      break if range.empty?
    end

    primes
  end
end
