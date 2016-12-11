class Board
  attr_reader :squares
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end

  def []=(num, marker)
    @squares[num] = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| unmarked?(key) }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?(key)
    @squares[key] == " "
  end

  def three_identical_markers?(squares)
    markers = squares.select { |sq| sq != " " }
    return false if markers.size != 3
    markers.min == markers.max
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)

        return squares.first
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = " " }
  end
end
