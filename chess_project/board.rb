require 'byebug'
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
    start = self[start_pos]
    ending = self[end_pos]
    raise StandardError, 'Invalid starting position' if start.is_a?(NullPiece) || start.nil?
    raise StandardError, 'Invalid ending position' if ending.nil?
    self[start_pos] = ending
    self[end_pos] = start
    
    if !start.is_a?(NullPiece)
      start.current_pos = end_pos
    elsif !ending.is_a?(NullPiece)
      ending.current_pos = start_pos
    elsif start.is_a?(Pawn)
      start.moved = true
    end
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
  # there is no piece at start_pos or
  # the piece cannot move to end_pos.
end

if $PROGRAM_NAME == __FILE__
  b = Board.new
  b.print

  #b.move_piece([0, 4], [2, 2])
  piece = b.grid[1][0]
  p piece
  #b.print
  p piece.move_dirs
  

  # b.print
  # b.move_piece([0, 2], [1, 0])
  # b.print
  # p b.move_piece([-1, 0], [3, 3])
  # p b.move_piece([0, 3], [-1, 0])
  # p b.move_piece([4, 0], [0, 0])
end
