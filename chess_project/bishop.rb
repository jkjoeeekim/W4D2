require_relative 'piece'
require_relative 'modules/slideable.rb'
class Bishop < Piece
  include Slideable
  def initialize(color)
    super(:B, color)
  end
end
