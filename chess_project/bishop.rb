require_relative 'piece'
require_relative 'modules/slideable.rb'

class Bishop < Piece
  include Slideable
  DIRS = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze

  def initialize(color, pos)
    super(:B, color, pos)
  end

  def move_dirs
    moves(pos, DIRS)
  end
end
