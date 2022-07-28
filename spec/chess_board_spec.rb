# frozen_string_literal: true

require_relative '../lib/chess_board'

describe ChessBoard do
  context '#initialize' do
    let(:blank_board) do
      "\n       _______________\n    8 |_|_|_|_|_|_|_|_|\n    7 |_|_|_|_|_|_|_|_|\n    6 |_|_|_|_|_|_|_|_|\n    5 |_|_|_|_|_|_|_|_|\n    4 |_|_|_|_|_|_|_|_|\n    3 |_|_|_|_|_|_|_|_|\n    2 |_|_|_|_|_|_|_|_|\n    1 |_|_|_|_|_|_|_|_|\n       a b c d e f g h\n    "
    end
    let(:chess_board) { ChessBoard.new }
    it 'generates a blank chess board' do
      expect(chess_board.board).to eq blank_board
    end
  end
end
