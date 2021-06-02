class Piece
  attr_accessor :board

  def initialize(value)
    @value = value
  end

  def inspect
    @value.inspect
  end
end
