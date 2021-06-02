require_relative 'piece'
require_relative 'modules/stepable'
require 'byebug'

class Pawn < Piece
  include Stepable
  attr_accessor :moved , :pos
  def initialize(color, pos, board)
    @moved = false
    super(:P, color, pos, board)
  end

  def move_dirs
    dirs = []
    row, col = current_pos
    if moved
      if color == 'WH'
        dirs << [-1, -1] if valid_index?((row - 1), (col - 1)) && board.grid[row - 1][col - 1].color == 'BL'
        dirs << [-1, 1] if valid_index?((row - 1), (col + 1)) && board.grid[row - 1][col + 1].color == 'BL'
        dirs << [-1, 0] if valid_index?((row - 1), col) && board.grid[row - 1][col].color == :NA
      else  # black
        dirs << [1, 1] if valid_index?((row + 1), (col + 1)) && board.grid[row + 1][col + 1].color == 'WH'
        dirs << [1, -1] if valid_index?((row + 1), (col - 1)) && board.grid[row + 1][col - 1].color == 'WH'
        dirs << [1, 0] if valid_index?((row + 1), col) && board.grid[row + 1][col].color == :NA
      end
    else # not moved
      if color == 'WH'
        dirs << [-1, -1] if valid_index?((row - 1), (col - 1)) && board.grid[row - 1][col - 1].color == 'BL'
        dirs << [-1, 1] if valid_index?((row - 1), (col + 1)) && board.grid[row - 1][col + 1].color == 'BL'

        if valid_index?((row - 1), col) && board.grid[row - 1][col].color == :NA
          dirs << [-1, 0]
          dirs << [-2, 0] if valid_index?((row - 2), col) && board.grid[row - 2][col].color == :NA
        end
      else # black
        # debugger
        dirs << [1, 1] if valid_index?((row + 1), (col + 1)) && board.grid[row + 1][col + 1].color == 'WH'
        dirs << [1, -1] if valid_index?((row + 1), (col - 1)) && board.grid[row + 1][col - 1].color == 'WH'

        if valid_index?((row + 1), col) && board.grid[row + 1][col].color == :NA
          dirs << [1, 0]
          dirs << [2, 0] if valid_index?((row + 2), col) && board.grid[row + 2][col].color == :NA
        end
      end
    end
    moves(current_pos, dirs)
  end

  def valid_index?(row, col)
    (0..7).to_a.include?(row) && (0..7).to_a.include?(col)
  end
end
