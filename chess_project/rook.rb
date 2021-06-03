require_relative 'piece'
require_relative 'modules/slideable.rb'

class Rook < Piece
  include Slideable
  DIRS = [[1, 0], [-1, 0], [0, 1], [0, -1]].freeze

  def move_dirs(new_grid = board.grid)
    moves(current_pos, DIRS)
  end
end
