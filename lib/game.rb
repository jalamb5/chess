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
    chess_board.board[6].each_with_index do |_item, column|
      pawn = ChessPiece.for(Pawn, :W, [6, column])
      chess_board.board[6][column] = pawn.symbol
    end
  end
end
