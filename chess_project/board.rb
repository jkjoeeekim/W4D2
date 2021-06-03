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
    # setup_board
    # Display.new(self)
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
    start = self[start_pos] # BL K
    ending = self[end_pos] # WH P
    raise StandardError, 'Invalid starting position' if start.is_a?(NullPiece) || start.nil?
    raise StandardError, 'Invalid ending position' if ending.nil?

    self[start_pos] = ending  # WH P
    self[end_pos] = start     # BL K

    start.current_pos = end_pos unless start.is_a?(NullPiece)
    unless ending.is_a?(NullPiece)
      # debugger
      ending.current_pos = start_pos
      self[start_pos] = NullPiece.instance
    end
    start.moved = true if start.is_a?(Pawn)
  end

  def setup_board
    grid.each_with_index do |row, idx|
      row.each_with_index do |piece, idx2|
        (idx.odd? || idx2.odd?) ? background = :green : background = :white
        pos = [idx, idx2]
        self[pos] = NullPiece.instance if (2..5).to_a.include?(idx)
        self[pos] = Pawn.new('♖'.colorize(:color => :red), 'BL', pos, self) if idx == 1
        self[pos] = Pawn.new('♖'.colorize(:color => :blue), 'WH', pos, self) if idx == 6
        case pos
        when [0, 0], [0, 7]
          self[pos] = Rook.new('♖'.colorize(:color => :red), 'BL', pos, self)
        when [7, 0], [7, 7]
          self[pos] = Rook.new('♖'.colorize(:color => :blue), 'WH', pos, self)
        when [0, 1], [0, 6]
          self[pos] = Knight.new('♔'.colorize(:color => :red), 'BL', pos, self)
        when [7, 1], [7, 6]
          self[pos] = Knight.new('♖'.colorize(:color => :blue), 'WH', pos, self)
        when [0, 2], [0, 5]
          self[pos] = Bishop.new('♔'.colorize(:color => :red), 'BL', pos, self)
        when [7, 2], [7, 5]
          self[pos] = Bishop.new('♖'.colorize(:color => :blue), 'WH', pos, self)
        when [0, 3]
          self[pos] = Queen.new('♖'.colorize(:color => :red), 'BL', pos, self)
        when [7, 3]
          self[pos] = Queen.new('♖'.colorize(:color => :blue), 'WH', pos, self)
        when [0, 4]
          self[pos] = King.new('♔'.colorize(:color => :red), 'BL', pos, self)
        when [7, 4]
          self[pos] = King.new('♔'.colorize(:color => :blue), 'WH', pos, self)
        end
      end
    end
    # add_background_color
  end

  def add_background_color
    grid.each_with_index do |row, idx|
      row.each_with_index do |ele, idx2|
        if idx.odd? || idx2.odd?
          grid[idx][idx2] = grid[idx][idx2].value.colorize(:background => :blue)
        end
      end
    end
  end

  def dup
    new_grid = Board.new

    grid.each_with_index do |row, idx1|
      row.each_with_index do |ele, idx2|
        # debugger
        new_grid.grid[idx1][idx2] = (ele.is_a?(NullPiece) ? NullPiece.instance : ele.dup)
      end
    end

    new_grid
  end

  # def inspect
  #   @grid.inspect
  # end

  def print
    @grid.each do |row|
      puts row.to_s
    end
  end

  def valid_pos?(pos)
    row, col = pos
    (0..7).to_a.include?(row) && (0..7).to_a.include?(col)
  end

  # White's turn end -> in_check?("BL") (check current turn if in check)
  def in_check?(color)
    opp_color = color == 'WH' ? 'BL' : 'WH'
    our_king = []
    opp_color_moves = []
    @grid.each_with_index do |row, idx|
      row.each_with_index do |ele, idx2|
        our_king.concat([idx, idx2]) if ele.color == color && ele.value == :K
        opp_color_moves.concat(ele.move_dirs(self)) if ele.color == opp_color
      end
    end
    opp_color_moves.include?(our_king)
  end

  def checkmate?(color)
    opp_color = color == 'WH' ? 'BL' : 'WH'
    valid_moves = find_moves(color)
    p valid_moves
    valid_moves.empty?
  end

  def find_moves(color)
    all_moves = []
    grid.each do |row|
      row.each do |ele|
        # debugger
        all_moves.concat(ele.valid_moves) if ele.color == color
        # p ele if ele.value == :K
        # p ele unless ele.valid_moves.empty? && !ele.is_a?(NullPiece) && ele.color != color
      end
    end
    all_moves
  end
  # there is no piece at start_pos or
  # the piece cannot move to end_pos.
end

b = Board.new
b.setup_board
b.print
b.move_piece([6, 1], [0, 3])
b.move_piece([6, 0], [0, 5])
b.move_piece([6, 2], [1, 3])
b.move_piece([6, 3], [1, 4])
b.move_piece([6, 4], [1, 5])
b.move_piece([6, 5], [2, 4])
b.move_piece([6, 6], [2, 5])
puts
b.print
p b.in_check?('BL')
p b.checkmate?('BL')
# debugger
# p b.grid[0][0].object_id
# p b.grid[0][0]

# new_b = b.dup
# p b.grid[4][1].object_id == new_b[4][1].object_id
# p new_b[0][0]
# b.print

# b.move_piece([6, 1], [2, 1])
# piece = b.grid[2][1]
# p piece.moved
# p piece
# b.print
# p piece.move_dirs
# p b.grid[1][1].move_dirs

# b.print
# b.move_piece([0, 2], [1, 0])
# b.print
# p b.move_piece([-1, 0], [3, 3])
# p b.move_piece([4, 0], [0, 0])
# p b.move_piece([0, 3], [-1, 0])
