require_relative 'piece'
require_relative 'modules/stepable'

class King < Piece
  include Stepable
  DIRS = [[1, 1], [1, -1], [1, 0], [-1, 1], [-1, -1], [-1, 0], [0, 1], [0, -1]].freeze

  def initialize(color, pos, board)
    super(:K, color, pos, board)
  end

  def move_dirs
    moves(current_pos, DIRS)
  end
end
