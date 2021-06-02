require_relative 'piece'
require_relative 'modules/slideable'

class Queen < Piece
  include Slideable
  DIRS = [[1, 1], [1, -1], [1, 0], [-1, 1], [-1, -1], [-1, 0], [0, 1], [0, -1]].freeze

  def initialize(color, pos)
    super(:Q, color, pos)
  end

  def move_dirs
    moves(pos, DIRS)
  end
end
