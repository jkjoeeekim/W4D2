require_relative "board.rb"
class Piece
    attr_accessor :board
    def initialize
        @board = Board.new
        setup_board
    end

    def setup_board
        board.each_with_index do |row,idx|
            if (3..5).to_a.include?(idx)
                row.each {|ele| ele = NullPiece.instance}
            elsif idx == 1 || idx == 6
                row.each {|ele| ele = Pawn.new}
            else
                row.each_with_index do |ele, idx2|
                    case idx2 
                    when 0 || 7
                        ele = Rook.new
                    when 1 || 6
                        ele = Knight.new
                    when 2 || 5
                        ele = Bishop.new
                    when 3
                        ele = Queen.new
                    when 4
                        ele = King.new
                    end
                end
            end
        end
    end
end
