require_relative 'piece'
require_relative 'modules/stepable.rb'
class Knight < Piece
  include Stepable
  def initialize(color)
    super(:N,color)
  end
end
