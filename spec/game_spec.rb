# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  context '#initialize' do
    let(:game) { Game.new }
    let(:row_two) { Array.new(8, '♙') }
    let(:row_seven) { Array.new(8, '♟') }

    it 'fills row 2 with white pawns' do
      expect(game.chess_board.board[6]).to eq row_two
    end

    it 'fills row 7 with black pawns' do
      expect(game.chess_board.board[1]).to eq row_seven
    end
  end
end
