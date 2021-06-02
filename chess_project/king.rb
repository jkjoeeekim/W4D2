require_relative 'piece'
require_relative 'modules/stepable'

class King < Piece
  include Stepable
  DIRS = [[1, 1], [1, -1], [1, 0], [-1, 1], [-1, -1], [-1, 0], [0, 1], [0, -1]].freeze

  def initialize(color, pos)
    super(:K, color, pos)
  end

  def move_dirs
    moves(pos, DIRS)
  end
end
