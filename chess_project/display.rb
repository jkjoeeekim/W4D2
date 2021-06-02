require_relative 'cursor'
require_relative 'board'
require 'colorize'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    while true
      puts "\n\n\n\n "
      board.grid.each_with_index do |row, idx1|
        new_row = []
        row.each_with_index do |ele, idx2|
          new_row << (([idx1, idx2] == cursor.cursor_pos) ? ele.value.to_s.colorize(:red) : ele.value.to_s.colorize(:blue))
        end
        puts "#{new_row.join}"
      end
      puts "\n\n\n\n "
      cursor.get_input
    end
  end
end

d = Display.new(Board.new)

b = d.board

b.move_piece([7, 3], [2, 4])
p b.in_check?("BL")
d.render




# b.print
# b.move_piece([0, 2], [1, 0])
# b.print
# p b.move_piece([-1, 0], [3, 3])
# p b.move_piece([0, 3], [-1, 0])
# p b.move_piece([4, 0], [0, 0])

