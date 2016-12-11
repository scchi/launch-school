class Human
  attr_reader :marker

  def set_marker(marker)
    @marker = marker
  end

  def move(unmarked_keys)
    square = nil

    loop do
      square = gets.chomp.to_i
      break if unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    square
  end
end
