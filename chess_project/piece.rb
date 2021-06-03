class Piece
  attr_accessor :board, :color, :current_pos
  attr_reader :value

  def initialize(value, color, pos, board)
    @value = value
    @color = color
    @current_pos = pos
    @board = board
  end

  def valid_moves
    all_moves = self.move_dirs
    all_moves.reject! { |pos| move_into_check?(pos) }
  end

  def move_into_check?(end_pos)
    new_board = board.dup
    new_board.move_piece(self.current_pos, end_pos)
    new_board.in_check?(self.color)
  end

  def inspect
    "#{@value} #{@color} #{current_pos}".inspect
  end
end
