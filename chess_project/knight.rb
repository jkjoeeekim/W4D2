require_relative 'piece'
require_relative 'modules/stepable.rb'

class Knight < Piece
  include Stepable
  DIRS = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  def initialize(color, pos)
    super(:N, color, pos)
  end

  def move_dirs
    moves(pos, DIRS)
  end
end
