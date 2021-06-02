class Piece
  attr_accessor :board , :color

  def initialize(value,color)
    @value = value
    @color = color
  end

  def inspect
    "#{@value} #{@color}".inspect
    
  end
end
