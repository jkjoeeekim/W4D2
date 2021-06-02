require 'byebug'

module Slideable
  def moves(pos, directions)
    possible_pos = []
    directions.each do |direction|
      row, col = pos
      row += direction[0]
      col += direction[1]
      #debugger
      while (0..7).to_a.include?(row) && (0..7).to_a.include?(col)
        break if self.board.grid[row][col].color == self.color
        possible_pos << [row, col]
        if self.color == 'WH' && self.board.grid[row][col].color == 'BL' 
            break
        elsif self.color == 'BL' && self.board.grid[row][col].color == 'WH'
            break
        end
        row += direction[0]
        col += direction[1]
      end
      
    end
    possible_pos
  end
end
