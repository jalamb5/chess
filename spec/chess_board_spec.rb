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
    let(:captured_rook) { Rook.new([1, 0], :W) }
    let(:capturing_rook) { Rook.new([0, 0], :B) }
    let(:registry) { [captured_rook, capturing_rook] }
    let(:pretty_board) do
      "8 |_|_|_|_|_|_|_|_|\n7 |_|_|_|_|_|_|_|_|\n6 |_|_|_|_|_|_|_|_|\n5 |_|_|_|_|_|_|_|_|\n4 |_|_|_|_|_|_|_|_|\n3 |_|_|_|_|_|_|_|_|\n2 |_|_|_|_|_|_|_|_|\n1 |_|_|_|_|_|_|_|_|\n   a b c d e f g h"
    end
    let(:captured_board) do
      "\n---==Captured==---\n♖\n8 |_|_|_|_|_|_|_|_|\n7 |♜|_|_|_|_|_|_|_|\n6 |_|_|_|_|_|_|_|_|\n5 |_|_|_|_|_|_|_|_|\n4 |_|_|_|_|_|_|_|_|\n3 |_|_|_|_|_|_|_|_|\n2 |_|_|_|_|_|_|_|_|\n1 |_|_|_|_|_|_|_|_|\n   a b c d e f g h\n---==Captured==---\n\n"
    end

    it 'prints the board to the terminal in a human readable way' do
      expect(chess_board.pretty_print).to eq pretty_board
    end

    it 'shows captured pieces' do
      capturing_rook.move([1, 0], registry)
      chess_board.update_board(registry)

      expect(chess_board.pretty_print).to eq captured_board
    end
  end

  context '#update_board' do
    let(:chess_board) { ChessBoard.new }
    let(:white_pawn) { Pawn.new([5, 5], :W) }
    let(:black_pawn) { Pawn.new([6, 6], :B) }
    let(:registry) { [white_pawn, black_pawn] }

    it 'displays pawns on the board' do
      chess_board.update_board(registry)

      expect(chess_board.board[5][5]).to eq('♙')
      expect(chess_board.board[6][6]).to eq('♟')
    end

    it 'removes white pawn from previous location' do
      chess_board.update_board(registry)
      white_pawn.move([6, 5], registry)
      chess_board.update_board(registry)

      expect(chess_board.board[5][5]).to eq('_')
    end

    it 'removes the black pawn when captured' do
      chess_board.update_board(registry)
      white_pawn.move([6, 6], registry)
      chess_board.update_board(registry)

      expect(chess_board.board[6][6]).to eq('♙')
    end
  end
end
