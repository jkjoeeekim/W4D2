require_relative 'piece'
require_relative 'modules/slideable.rb'
class Queen < Piece
  include Slideable
  def initialize(color)
    super(:Q,color)
  end
end
