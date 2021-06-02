require 'singleton'
require_relative 'piece'

class NullPiece < Piece
  include Singleton

  def initialize
    super(:E, :NA, :NA)
  end
end
