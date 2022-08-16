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

  context '#update_board' do
    let(:chess_board) { ChessBoard.new }
    let(:white_pawn) { Pawn.new([0, 0], :W) }
    let(:registry) { [white_pawn] }

    it 'displays a white pawn on the board' do
      chess_board.update_board(white_pawn)

      expect(chess_board.board[0][0]).to eq('♙')
    end

    it 'removes white pawn from previous location' do
      chess_board.update_board(white_pawn)
      white_pawn.move([1, 0], registry)
      chess_board.update_board(white_pawn)

      expect(chess_board.board[0][0]).to eq('_')
    end
  end
end
