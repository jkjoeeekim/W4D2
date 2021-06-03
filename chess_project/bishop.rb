require_relative 'piece'
require_relative 'modules/slideable.rb'

class Bishop < Piece
  include Slideable
  DIRS = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  
  def move_dirs(new_grid = board.grid)
    moves(current_pos, DIRS)
  end
end
