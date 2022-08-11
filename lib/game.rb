# frozen_string_literal: true

require_relative '../lib/chess_board'

# Generate objects needed for game and gameloop
class Game
  attr_accessor :chess_board, :registry

  NEW_GAME_LOCATIONS = [
    [[7, 4], King, :W],
    [[0, 4], King, :B],
    [[7, 3], Queen, :W],
    [[0, 3], Queen, :B],
    [[7, 0], Rook, :W],
    [[0, 0], Rook, :B],
    [[7, 2], Bishop, :W],
    [[0, 2], Bishop, :B],
    [[7, 1], Knight, :W],
    [[0, 1], Knight, :B]
  ].freeze

  def initialize
    @chess_board = ChessBoard.new
    @registry = []
    fill_board
    # puts "\n#{chess_board.pretty_print}"
  end

  private

  def fill_board
    fill_row(6, Pawn, :W)
    fill_row(1, Pawn, :B)
    NEW_GAME_LOCATIONS.each { |piece| add_piece(piece[0], piece[1], piece[2]) }
  end

  def fill_row(row, piece_type, color)
    chess_board.board[row].each_with_index do |_item, column|
      piece = ChessPiece.for(piece_type, color, [row, column])
      registry << piece
      chess_board.board[row][column] = piece.symbol
    end
  end

  def add_piece(location, piece_type, color)
    piece = ChessPiece.for(piece_type, color, location)
    registry << piece
    chess_board.board[location[0]][location[1]] = piece.symbol
  end
end
