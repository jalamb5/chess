# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  context '#initialize' do
    let(:game) { Game.new }
    let(:pieces) do
      {
        white_pawn: '♙',
        black_pawn: '♟',
        white_king: '♔',
        black_king: '♚',
        white_queen: '♕',
        black_queen: '♛',
        white_rook: '♖',
        black_rook: '♜',
        white_bishop: '♗',
        black_bishop: '♝',
        white_knight: '♘',
        black_knight: '♞'
      }
    end
    let(:row_two) { Array.new(8, pieces[:white_pawn]) }
    let(:row_seven) { Array.new(8, pieces[:black_pawn]) }

    it 'fills row 2 with white pawns' do
      expect(game.chess_board.board[6]).to eq row_two
    end

    it 'fills row 7 with black pawns' do
      expect(game.chess_board.board[1]).to eq row_seven
    end

    it 'creates a register of chess pieces' do
      expect(game.registry.length).to eq(32)
    end

    it 'adds white king to board' do
      expect(game.chess_board.board[7][4]).to eq pieces[:white_king]
    end
  end

  context '#play' do
    subject { Game.new }
    let(:welcome_message) { "Welcome to Chess.\n#{subject.chess_board.pretty_print}\nWhite goes first" }
    xit 'puts a welcome message' do
      expect { subject.play }.to output(welcome_message).to_stdout
    end
  end

  context '#game_over' do
    subject { Game.new }

    it 'checks Kings for checkmate' do
      expect(subject.game_over).to eq false
    end
  end
end
