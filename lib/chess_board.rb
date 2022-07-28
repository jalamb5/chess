# frozen_string_literal: true

# Make an 8x8 board to place pieces upon.
class ChessBoard
  attr_accessor :board

  def initialize
    @board = build_board
  end

  def pretty_print
    board_string = String.new
    board_length = board.length

    board.each do |row|
      board_string << "#{board_length} "
      board_length -= 1
      row.each do |i|
        board_string << "|#{i}"
      end
      board_string << "|\n"
    end
    board_string << '   a b c d e f g h'
  end

  private

  def build_board
    Array.new(8) { Array.new(8) { '_' } }
  end

  def build_board_string(board_length)
    board.each do |row|
      board_string << "#{board_length} "
      board_length -= 1
      row.each do |i|
        board_string << "|#{i}"
      end
      board_string << "|\n"
    end
    board_string << '   a b c d e f g h'
  end
end
