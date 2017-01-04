class BeerSong
  ZERO = <<-HERE
No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
  HERE
  ONE = <<-HERE
1 bottle of beer on the wall, 1 bottle of beer.
Take it down and pass it around, no more bottles of beer on the wall.
  HERE

  def verse(number)
    case number
      when 0 then ZERO
      when 1 then ONE
      else
        <<-HERE
#{number} bottles of beer on the wall, #{number} bottles of beer.
Take one down and pass it around, #{number - 1} #{(number - 1) > 1 ? "bottles" : "bottle" } of beer on the wall.
        HERE
    end
  end

  def verses(from, to)
    if from == to
      verse(from)
    else
      verse(from) + "\n" + verses(from - 1, to)
    end
  end

  def lyrics
    verses(99, 0)
  end
end
