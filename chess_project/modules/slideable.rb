require 'byebug'

module Slideable
  def moves(pos, directions)
    possible_pos = []
    directions.each do |direction|
      row, col = pos
      row += direction[0]
      col += direction[1]
      # debugger
      while (0..7).to_a.include?(row) && (0..7).to_a.include?(col)
        break if board.grid[row][col].color == color

        possible_pos << [row, col]
        if color == 'WH' && board.grid[row][col].color == 'BL'
          break
        elsif color == 'BL' && board.grid[row][col].color == 'WH'
          break
        end

        row += direction[0]
        col += direction[1]
      end
    end
    possible_pos
  end
end
