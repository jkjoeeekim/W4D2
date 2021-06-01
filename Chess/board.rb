class Board
    attr_accessor :board
    def initialize
        @board = Array.new(8) {Array.new(8)}
    end
    def [](pos)
        x, y = pos
        board[x][y]
    end
    def []=(pos,val)
        x, y = pos
        board[x][y] = val
    end
    def move_piece(start_pos, end_pos)
        
        start = board[start_pos]
        ending = board[end_pos]
        if start == NullPiece
            raise StandardError.new("Can't move this piece")
        elsif !ending 
            raise StandardError.new("Invalid ending position")
        end
        #Only works if moving to NullPiece as of now
        board[start_pos] = ending
        board[end_pos] = start
    end
    
    #there is no piece at start_pos or
    #the piece cannot move to end_pos.
end