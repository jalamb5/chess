# frozen_string_literal: true

require_relative '../lib/chess_board'

describe ChessBoard do
  context '#initialize' do
    let(:blank_board) do
      [
        %w[_ _ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _ _]
      ]
    end
    let(:chess_board) { ChessBoard.new }

    it 'generates a blank chess board' do
      expect(chess_board.board).to eq blank_board
    end
  end

  context '#pretty_print' do
    let(:chess_board) { ChessBoard.new }
    let(:pretty_board) do
      "8 |_|_|_|_|_|_|_|_|\n7 |_|_|_|_|_|_|_|_|\n6 |_|_|_|_|_|_|_|_|\n5 |_|_|_|_|_|_|_|_|\n4 |_|_|_|_|_|_|_|_|\n3 |_|_|_|_|_|_|_|_|\n2 |_|_|_|_|_|_|_|_|\n1 |_|_|_|_|_|_|_|_|\n   a b c d e f g h"
    end

    it 'prints the board to the terminal in a human readable way' do
      expect(chess_board.pretty_print).to eq pretty_board
    end
  end
end
