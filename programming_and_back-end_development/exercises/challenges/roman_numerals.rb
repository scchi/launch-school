
class Fixnum
  ROMAN_TO_DIGITS = {"M" => 1000, "CM" => 900, "D" => 500, "CD" => 400,
                     "C" => 100,  "XC" => 90,  "L" => 50,  "XL" => 40,
                     "X" => 10,   "IX" => 9,   "V" => 5,   "IV" => 4,    "I" => 1 }

  def to_roman
    num = self
    result = ""

    ROMAN_TO_DIGITS.each do |key, value|
      next if num < value
      repetition = ["CM", "CD", "XC", "XL", "IX", "IV"].include?(key) ? 1 : (num/value)

      result += key * repetition
      num -= repetition * value

      break if num == 0
    end

    result
  end
end
