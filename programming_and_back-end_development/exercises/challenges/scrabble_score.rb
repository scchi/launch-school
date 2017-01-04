class Scrabble
  LETTER_TO_SCORE = { %w(a e i o u l n r s t) => 1, %w(d, g) => 2,  # => 2
                      %w(b c m p) => 3, %w(f h v w y) => 4,         # => 4
                      %w(k) => 5, %w(j x) => 8, %(q z) => 10 }      # => {["a", "e", "i", "o", "u", "l", "n", "r", "s", "t"]=>1, ["d,", "g"]=>2, ["b", "c", "m", "p"]=>3, ["f", "h", "v", "w", "y"]=>4, ["k"]=>5, ["j", "x"]=>8, "q z"=>10}

  def self.score(word)
    Scrabble.new(word).score
  end                         # => :score

  def initialize(word)
    @word = word.to_s.strip.downcase
  end                                 # => :initialize

  def score
    result = 0
    @word.chars do |letter|
      LETTER_TO_SCORE.each do |k, v|
        result += v if k.include?(letter)
      end
    end
    result
  end                                      # => :score
end                                        # => :score
