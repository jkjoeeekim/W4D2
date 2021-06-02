require_relative 'piece'
require_relative 'modules/slideable.rb'

class Rook < Piece
  include Slideable
  DIRS = [[1, 0], [-1, 0], [0, 1], [0, -1]].freeze

  def initialize(color, pos)
    super(:R, color, pos)
  end

  def move_dirs
    moves(current_pos, DIRS)
  end
end
