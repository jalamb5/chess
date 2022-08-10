# frozen_string_literal: true

require_relative '../lib/chess_board'

# Generate objects needed for game and gameloop
class Game
  attr_accessor :chess_board, :registry

  def initialize
    @chess_board = ChessBoard.new
    @registry = []
    fill_board
  end

  private

  def fill_board
    fill_row(6, Pawn, :W)
    fill_row(1, Pawn, :B)
  end

  def fill_row(row, piece_type, color)
    chess_board.board[row].each_with_index do |_item, column|
      piece = ChessPiece.for(piece_type, color, [row, column])
      registry << piece
      chess_board.board[row][column] = piece.symbol
    end
  end
end
