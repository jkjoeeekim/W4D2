class Piece
  attr_accessor :board, :color, :current_pos

  def initialize(value, color, pos)
    @value = value
    @color = color
    @current_pos = pos
  end

  def inspect
    "#{@value} #{@color} #{current_pos}".inspect
  end
end
