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
  end

  def setup_board
    grid.each_with_index do |row, idx|
      if (2..5).to_a.include?(idx)
        row.map! { |_piece| NullPiece.instance }
      elsif [1, 6].include?(idx)
        row.map! { |_piece| Pawn.new }
      else
        row.each_with_index do |_piece, idx2|
          pos = [idx, idx2]
          case idx2
          when 0, 7
            self[pos] = Rook.new
          when 1, 6
            self[pos] = Knight.new
          when 2, 5
            self[pos] = Bishop.new
          when 3
            self[pos] = Queen.new
          when 4
            self[pos] = King.new
          end
        end
      end
    end
  end

  def inspect
    @grid.inspect
  end

  # there is no piece at start_pos or
  # the piece cannot move to end_pos.
end

if $PROGRAM_NAME == __FILE__
  b = Board.new
  p b
  b.move_piece([0, 0], [0, 1])
  p b
  b.move_piece([0, 2], [1, 0])
  p b
  # p b.move_piece([-1, 0], [3, 3])
  # p b.move_piece([0, 3], [-1, 0])
  # p b.move_piece([4, 0], [0, 0])
end
