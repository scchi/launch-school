class Square
  INITIAL_MARKER = " ".freeze

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end



  def to_s
    @marker
  end


end
