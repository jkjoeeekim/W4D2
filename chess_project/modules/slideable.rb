module Slideable
    def moves(pos, directions)
        possible_pos = []
        row , col = pos 
        directions.each do |direction|
            until row.zero?  || col.zero? || row == 7 || col == 7
                row += direction[0]
                rol += direction[1]
                possible_pos << [row,col]
            end
        end
        possible_pos
    end
end