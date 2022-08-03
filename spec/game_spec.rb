# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  context '#initialize' do
    let(:game) { Game.new }
    let(:blank_board) { Array.new(8) { Array.new(8) { '_' } } }

    it 'makes a board' do
      expect(game.chess_board.board).to eq blank_board
    end
  end
end
