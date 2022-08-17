# frozen_string_literal: true

# Make an 8x8 board to place pieces upon.
class ChessBoard
  attr_accessor :board, :captured_pieces

  def initialize
    @board = build_board
    @captured_pieces = []
  end

  def pretty_print
    build_pp_string(board.length)
  end

  def update_board(registry)
    registry.each do |piece|
      remove_piece(piece) if piece.captured
      clear_previous_square(piece) unless piece.previous_location.nil?
      place_piece(piece) unless piece.captured
    end
  end

  private

  def build_board
    Array.new(8) { Array.new(8) { '_' } }
  end

  def build_pp_string(board_length)
    pp_string = String.new
    case captured_pieces
    when captured_pieces.empty?
      pp_string << show_chess_board(board_length)
    else
      pp_string << show_captured_pieces(captured_pieces, :W)
      pp_string << show_chess_board(board_length)
      pp_string << show_captured_pieces(captured_pieces, :B)
    end
  end

  def show_chess_board(board_length)
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

  def show_captured_pieces(captured_pieces, color)
    captured_string = String.new
    captured_string << "\n---==Captured==---\n"

    captured_pieces.each do |piece|
      captured_string << piece.symbol if piece.color == color
    end
    captured_string << "\n"
  end

  def place_piece(piece)
    board[piece.location[0]][piece.location[1]] = piece.symbol
  end

  def clear_previous_square(piece)
    board[piece.previous_location[0]][piece.previous_location[1]] = '_'
  end

  def remove_piece(piece)
    board[piece.location[0]][piece.location[1]] = '_' if board[piece.location[0]][piece.location[1]] == piece.symbol
    piece.location = nil
    piece.previous_location = nil
    captured_pieces << piece
  end
end
