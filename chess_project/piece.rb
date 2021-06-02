class Piece
  attr_accessor :board, :color, :current_pos
  attr_reader :value

  def initialize(value, color, pos, board)
    @value = value
    @color = color
    @current_pos = pos
    @board = board
  end

  def inspect
    "#{@value} #{@color} #{current_pos}".inspect
  end
end
