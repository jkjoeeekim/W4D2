require 'byebug'
require 'colorize'
require_relative 'king'
require_relative 'piece'
require_relative 'queen'
require_relative 'bishop'
require_relative 'knight'
require_relative 'rook'
require_relative 'pawn'
require_relative 'null_piece'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    setup_board
    Display.new(self)
  end

  def [](pos)
    x, y = pos
    return nil unless (0..7).to_a.include?(x) && (0..7).to_a.include?(y)

    grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    return nil unless (0..7).to_a.include?(x) && (0..7).to_a.include?(y)

    grid[x][y] = val
  end
  
  def move_piece(start_pos, end_pos)
    start = self[start_pos] #BL K
    ending = self[end_pos] #WH P
    raise StandardError, 'Invalid starting position' if start.is_a?(NullPiece) || start.nil?
    raise StandardError, 'Invalid ending position' if ending.nil?

    self[start_pos] = ending  #WH P
    self[end_pos] = start     #BL K

    if !start.is_a?(NullPiece)
      start.current_pos = end_pos
    end
    if !ending.is_a?(NullPiece)
      ending.current_pos = start_pos
      self[start_pos] = NullPiece.instance
    end
    start.moved = true if start.is_a?(Pawn)


  end

  def setup_board
    grid.each_with_index do |row, idx|
      row.each_with_index do |_piece, idx2|
        pos = [idx, idx2]
        self[pos] = NullPiece.instance if (2..5).to_a.include?(idx)
        self[pos] = Pawn.new('BL', pos , self) if idx == 1
        self[pos] = Pawn.new('WH', pos , self) if idx == 6
        case pos
        when [0, 0], [0, 7]
          self[pos] = Rook.new('BL', pos , self)
        when [7, 0], [7, 7]
          self[pos] = Rook.new('WH', pos , self)
        when [0, 1], [0, 6]
          self[pos] = Knight.new('BL', pos , self)
        when [7, 1], [7, 6]
          self[pos] = Knight.new('WH', pos , self)
        when [0, 2], [0, 5]
          self[pos] = Bishop.new('BL', pos , self)
        when [7, 2], [7, 5]
          self[pos] = Bishop.new('WH', pos , self)
        when [0, 3]
          self[pos] = Queen.new('BL', pos , self)
        when [7, 3]
          self[pos] = Queen.new('WH', pos , self)
        when [0, 4]
          self[pos] = King.new('BL', pos , self)
        when [7, 4]
          self[pos] = King.new('WH', pos , self)
        end
      end
    end
  end

  def inspect
    @grid.inspect
  end

  def print
    @grid.each do |row|
      puts row.to_s
    end
  end

  def valid_pos?(pos)
    row, col = pos
    (0..7).to_a.include?(row) && (0..7).to_a.include?(col)
  end
 
  def in_check?(color) #White's turn end -> in_check?("BL") (check current turn if in check)
    color == "WH" ? opp_color = "BL" : opp_color = "WH"
    our_king = []
    opp_color_moves = []    
    @grid.each_with_index do |row, idx|
      row.each_with_index do |ele, idx2|
        our_king += [idx, idx2] if ele.color == color && ele.value == :K
        opp_color_moves += ele.move_dirs if ele.color == opp_color
      end
    end
    opp_color_moves.include?(our_king)
    checkmate?(color)
  end
  # there is no piece at start_pos or
  # the piece cannot move to end_pos.
end

if $PROGRAM_NAME == __FILE__
  b = Board.new
  b.print

  b.move_piece([6, 1], [2, 1])
  piece = b.grid[2][1]
  p piece.moved
  p piece
  b.print
  p piece.move_dirs
  p b.grid[1][1].move_dirs
  

  # b.print
  # b.move_piece([0, 2], [1, 0])
  # b.print
  # p b.move_piece([-1, 0], [3, 3])
  # p b.move_piece([0, 3], [-1, 0])
  # p b.move_piece([4, 0], [0, 0])
end
