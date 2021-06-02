require_relative 'piece'
require_relative 'modules/stepable.rb'
class King < Piece
  include Stepable
  def initialize(color)
    super(:K,color)
  end
end
