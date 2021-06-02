require_relative 'piece'
require_relative 'modules/stepable'
class Pawn < Piece
  include Stepable
  attr_accessor :moved , :pos
  def initialize(color, pos, board)
    @moved = false
    super(:P, color, pos, board)
  end

  def move_dirs
    dirs = []
    row, col = pos
    if moved 
      if color == "WH"
        dirs << [-1, 0]
        dirs << [-1, -1] if board.grid[row-1][col-1].color = "BL"
        dirs << [-1, 1] if board.grid[row-1][col+1].color = "BL"
      else  #black
        dirs << [1, 0]
        dirs << [1, 1] if board.grid[row+1][col+1].color = "WH"
        dirs << [1, -1] if board.grid[row+1][col-1].color = "WH"
      end
    else  #not moved
      if color == "WH"
        dirs << [1, 0] << [2, 0]
        dirs << [-1, -1] if board.grid[row-1][col-1].color = "BL"
        dirs << [-1, 1] if board.grid[row-1][col+1].color = "BL"
      else #black
        dirs << [-1, 0] << [-2, 0]
        dirs << [1, 1] if board.grid[row+1][col+1].color = "WH"
        dirs << [1, -1] if board.grid[row+1][col-1].color = "WH"
      end
    end
    moves(current_pos, dirs)
  end

end
