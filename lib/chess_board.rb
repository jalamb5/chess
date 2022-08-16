# frozen_string_literal: true

# Make an 8x8 board to place pieces upon.
class ChessBoard
  attr_accessor :board

  def initialize
    @board = build_board
  end

  def pretty_print
    build_board_string(board.length)
  end

  def update_board(registry)
    registry.each do |piece|
      place_piece(piece) unless piece.captured
      clear_previous_square(piece) unless piece.previous_location.nil?
      remove_piece(piece) if piece.captured
    end
  end

  private

  def build_board
    Array.new(8) { Array.new(8) { '_' } }
  end

  def build_board_string(board_length)
    board_string = String.new

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

  def place_piece(piece)
    board[piece.location[0]][piece.location[1]] = piece.symbol
  end

  def clear_previous_square(piece)
    board[piece.previous_location[0]][piece.previous_location[1]] = '_'
  end

  def remove_piece(piece)
    board[piece.location[0]][piece.location[1]] = '_'
  end
end
