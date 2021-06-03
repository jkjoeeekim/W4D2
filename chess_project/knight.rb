require_relative 'piece'
require_relative 'modules/stepable.rb'

class Knight < Piece
  include Stepable
  DIRS = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  def move_dirs(new_grid = board.grid)
    moves(current_pos, DIRS)
  end
end
