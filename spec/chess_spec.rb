# frozen_string_literal: true

require_relative '../lib/chess_pieces'

describe ChessPiece do
  context '#for' do
    let(:pawn) { ChessPiece.for(Pawn, :a2) }

    it 'creates a pawn' do
      expect(pawn).to be_an_instance_of Pawn
    end
  end

  describe Pawn do
    let(:pawn) { Pawn.new(:a2) }

    context '#initialize' do
      it 'creates a pawn' do
        expect(pawn).to be_an_instance_of Pawn
      end

      it 'places the pawn on a board space' do
        expect(pawn.location).to eq :a2
      end

      it 'displays "P" as symbol' do
        expect(pawn.symbol).to eq 'P'
      end
    end
  end
end
