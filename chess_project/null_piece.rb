require 'singleton'
require_relative 'piece'

class NullPiece < Piece
  include Singleton

  def initialize
    super(' ', :NA, :NA, :NA)
  end
end
