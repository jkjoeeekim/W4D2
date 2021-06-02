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
d.render