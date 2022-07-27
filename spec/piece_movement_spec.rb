# frozen_string_literal: true

require_relative '../lib/piece_movement'
require_relative '../lib/chess_pieces'

describe Movement do
  context '#move' do
    let(:pawn) { ChessPiece.for(Pawn, :W, :a2) }

    it 'moves a piece from one location to another' do
      pawn.move(:a3)
      expect(pawn.location).to eq :a3
    end

    it 'updates previous location' do
      pawn.move(:a3)
      expect(pawn.previous_location).to eq :a2
    end

    it 'disallows invalid moves' do
      expect(pawn.move(:a21)).to eq('some error message')
    end
  end
end
