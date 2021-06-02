require_relative 'piece'
require_relative 'modules/slideable.rb'

class Bishop < Piece
  include Slideable
  DIRS = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze

  def initialize(color, pos, board)
    super(:B, color, pos, board)
  end

  def move_dirs
    moves(current_pos, DIRS)
  end
end
