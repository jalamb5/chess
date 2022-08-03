# frozen_string_literal: true

require_relative '../lib/chess_board'

# Generate objects needed for game and gameloop
class Game
  attr_accessor :chess_board

  def initialize
    @chess_board = ChessBoard.new
  end
end
