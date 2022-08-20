# frozen_string_literal: true

require_relative '../lib/piece_movement'
require_relative '../lib/chess_pieces'

describe Movement do
  context '#move' do
    let(:new_location) { [1, 2] }
    let(:original_location) { [0, 2] }
    let(:pawn) { ChessPiece.for(Pawn, :W, original_location) }
    let(:en_passant_pawn) { ChessPiece.for(Pawn, :B, [2, 3]) }
    let(:registry) { [pawn, en_passant_pawn] }

    it 'moves a piece from one location to another' do
      pawn.move(new_location, registry)
      expect(pawn.location).to eq new_location
    end

    it 'updates previous location' do
      pawn.move(new_location, registry)
      expect(pawn.previous_location).to eq original_location
    end

    it 'marks the piece as has_moved' do
      pawn.move(new_location, registry)
      expect(pawn.has_moved).to eq true
    end

    it 'disallows invalid moves' do
      expect(pawn.move([0, 21], registry)).to eq('invalid move')
    end

    it 'allows a pawn to capture en passant' do
      pawn.move([2, 2], registry)
      en_passant_pawn.move([1, 2], registry)
      expect(pawn.en_passant).to eq(true)
      expect(pawn.captured).to eq(true)
    end
  end
end
