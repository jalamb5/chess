# frozen_string_literal: true

require_relative '../lib/chess_pieces'

describe ChessPiece do
  context '#for' do
    let(:pawn) { ChessPiece.for(Pawn, :W, :a2) }

    it 'creates a pawn' do
      expect(pawn).to be_an_instance_of Pawn
    end

    it 'places the pawn on a board space' do
      expect(pawn.location).to eq :a2
    end

    it 'makes the pawn white' do
      expect(pawn.color).to eq :W
    end

    it 'has no previous location' do
      expect(pawn.previous_location).to be_nil
    end
  end

  describe Pawn do
    let(:pawn) { Pawn.new(:a2, :W) }

    context '#initialize' do
      it 'displays "P" as symbol' do
        expect(pawn.symbol).to eq 'P'
      end

      it 'is not eligible for en passant' do
        expect(pawn.en_passant).to eq false
      end

      it 'can move to a new location' do
        pawn.location = :a3
        expect(pawn.location).to eq :a3
      end
    end
  end
end
