class Series
  include Enumerable

  def initialize(number)
    @number = number
  end

  def slices(n)
    size < n ? raise(ArgumentError) : each_cons(n).to_a
  end

  private

  def each
    @number.split(//).each { |num| yield(num.to_i) }
  end

  def size
    @number.size
  end
end
