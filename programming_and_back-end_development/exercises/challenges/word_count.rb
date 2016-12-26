class Phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    count = Hash.new(0)
    @phrase.split(/\b[^\w']+\b/).each { |word| count[word.downcase] += 1 }
    count
  end
end
