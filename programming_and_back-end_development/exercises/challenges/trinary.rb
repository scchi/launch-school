class Trinary
  def initialize(num)
    @num = check_input(num)
    @enum = generate_enum
  end

  def check_input(num)
    num =~ /[^0-2]/ ? [0] : num.split(//).map(&:to_i).reverse
  end

  def gen_enum
    Enumerator.new do |y|
      0.upto(@num.size - 1) { |exp| y << (@num[exp] * (3 ** exp))  }
    end
  end

  def to_decimal
    @enum.inject(:+)
  end
end
