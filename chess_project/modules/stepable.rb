module Stepable
  def moves(pos, directions)
    possible_pos = []
    directions.each do |direction|
      row, col = pos
      row += direction[0]
      col += direction[1]

      next unless (0..7).to_a.include?(row) && (0..7).to_a.include?(col)

      possible_pos << [row, col] if board.grid[row][col].color != color
    end
    possible_pos
  end
end
