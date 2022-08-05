# frozen_string_literal: true

require_relative '../lib/chess_pieces'
require_relative '../lib/piece_movement'

describe ChessPiece do
  context '#for' do
    let(:pawn) { ChessPiece.for(Pawn, :W, [0, 2]) }

    it 'creates a pawn' do
      expect(pawn).to be_an_instance_of Pawn
    end

    it 'places the pawn on a board space' do
      expect(pawn.location).to eq [0, 2]
    end

    it 'makes the pawn white' do
      expect(pawn.color).to eq :W
    end

    it 'has no previous location' do
      expect(pawn.previous_location).to be_nil
    end
  end

  describe Pawn do
    let(:pawn) { Pawn.new([0, 2], :W) }
    let(:black_pawn) { Pawn.new([0, 2], :B) }
    let(:pawn_forward_two) { [[2, 2], [1, 2]] }

    context '#initialize' do
      it 'displays "♙" as symbol for white pawn' do
        expect(pawn.symbol).to eq '♙'
      end

      it 'displays "♟" as symbol for black pawn' do
        expect(black_pawn.symbol).to eq '♟'
      end

      it 'is not eligible for en passant' do
        expect(pawn.en_passant).to eq false
      end

      it 'can update its location' do
        pawn.location = [0, 3]
        expect(pawn.location).to eq [0, 3]
      end

      it 'generates a list of legal moves' do
        expect(pawn.legal_moves).to eq pawn_forward_two
      end
    end
  end

  describe King do
    let(:white_king) { King.new([0, 2], :W) }
    let(:black_king) { King.new([1, 2], :B) }
    let(:king_moves) { [[0, 3], [0, 1], [1, 2], [-1, 2]] }

    context '#initialize' do
      it 'displays "♔" symbol for white king' do
        expect(white_king.symbol).to eq '♔'
      end

      it 'displays "♚" symbol for black king' do
        expect(black_king.symbol).to eq '♚'
      end

      it 'can update its location' do
        white_king.location = [1, 2]
        expect(white_king.location).to eq [1, 2]
      end

      it 'generates a list of legal moves' do
        expect(white_king.legal_moves).to eq king_moves
      end
    end
  end
end
