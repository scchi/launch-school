class SecretHandshake
  def initialize(num)
    @num = "%05b" % num.to_i
    @moves = ["jump", "close your eyes", "double blink", "wink"]
  end

  def commands
    commands_array = @num.chars.last(4).zip(@moves).map { |mv| mv[1] if mv[0] == "1"}.compact
    @num[0] == "1" ? commands_array : commands_array.reverse
  end
end
