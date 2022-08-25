# frozen_string_literal: true

require_relative '../lib/movement/piece_movement'
require_relative '../lib/chess_pieces'

describe Movement do
  context '#move' do
    let(:new_location) { [1, 2] }
    let(:original_location) { [0, 2] }
    let(:pawn) { ChessPiece.for(Pawn, :B, original_location) }
    let(:en_passant_pawn) { ChessPiece.for(Pawn, :W, [2, 3]) }
    let(:checked_king) { ChessPiece.for(King, :B, [0, 0]) }
    let(:checking_rook) { ChessPiece.for(Rook, :W, [1, 1]) }
    let(:registry) { [pawn, en_passant_pawn, checked_king, checking_rook] }

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

    it 'marks pawn as en passant eligible' do
      pawn.move([2, 2], registry)
      expect(pawn.en_passant).to eq(true)
    end

    it 'captures an en passant pawn' do
      pawn.move([2, 2], registry)
      en_passant_pawn.move([1, 2], registry)
      expect(pawn.captured).to eq(true)
    end

    it 'marks a king as checked after another piece moves' do
      checking_rook.move([0, 1], registry)
      expect(checked_king.check).to be true
    end
  end
end
