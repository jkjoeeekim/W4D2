require_relative 'piece'
require_relative 'modules/slideable.rb'
class Rook < Piece
  include Slideable
  def initialize(color)
    super(:R,color)
  end
end
