require_relative 'piece'

class Pawn < Piece
  def initialize(color, pos)
    super(:P, color, pos)
  end
end
