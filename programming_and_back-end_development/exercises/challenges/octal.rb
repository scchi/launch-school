class Octal
  include Enumerable

  def initialize(num)
     @num = check_input(num)
  end

  def check_input(num)
    num =~ /[^0-7]/ ? [0] : num.split(//).map(&:to_i).reverse
  end

  def each
    0.upto(@num.size - 1 ) { |exp| yield( @num[exp] * (8 ** exp) ) }
  end

  def to_decimal
    inject(:+)
  end
end
