require_relative 'piece'

class Pawn < Piece
  def initialize(color)
    super(:P,color)
  end
end
