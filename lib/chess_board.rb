# frozen_string_literal: true

class ChessBoard
  attr_accessor :board

  def initialize
    @board = build_board
  end

  private

  def build_board
    Array.new(8) { Array.new(8) { '_' } }
  end
end
