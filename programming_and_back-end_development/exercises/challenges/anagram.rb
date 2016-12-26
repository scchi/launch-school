class Anagram
  def initialize(word)
    @word = word
    @letters = letters(word)
  end

  def match(word_array)
    word_array.sort.select { |word| anagram? word }
  end

  def anagram?(word)
    @word.downcase != word.downcase  && @letters == letters(word)
  end

  def letters(word)
    word.downcase.split(//).sort
  end
end
