# frozen_string_literal: true

require_relative '../lib/piece_movement'
require_relative '../lib/chess_pieces'

describe Movement do
  context '#move' do
    let(:new_location) { [1, 2] }
    let(:original_location) { [0, 2] }
    let(:pawn) { ChessPiece.for(Pawn, :W, original_location) }

    it 'moves a piece from one location to another' do
      pawn.move(new_location)
      expect(pawn.location).to eq new_location
    end

    it 'updates previous location' do
      pawn.move(new_location)
      expect(pawn.previous_location).to eq original_location
    end

    it 'marks the piece as has_moved' do
      pawn.move(new_location)
      expect(pawn.has_moved).to eq true
    end

    it 'disallows invalid moves' do
      expect(pawn.move([0, 21])).to eq('invalid move')
    end
  end
end
