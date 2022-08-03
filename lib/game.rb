# frozen_string_literal: true

require_relative '../lib/chess_board'

# Generate objects needed for game and gameloop
class Game
  attr_accessor :chess_board

  def initialize
    @chess_board = ChessBoard.new
    fill_board
  end

  private

  def fill_board
    add_piece(6, Pawn, :W)
    add_piece(1, Pawn, :B)
  end

  def add_piece(row, piece_type, color)
    chess_board.board[row].each_with_index do |_item, column|
      piece = ChessPiece.for(piece_type, color, [row, column])
      chess_board.board[row][column] = piece.symbol
    end
  end
end
