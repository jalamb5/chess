# frozen_string_literal: true

require_relative '../lib/movement/king_movement'
require_relative '../lib/movement/piece_movement'
require_relative '../lib/chess_pieces'

describe KingMovement do
  context '#in_check?' do
    let(:black_king) { ChessPiece.for(King, :B, [0, 0]) }
    let(:white_king) { ChessPiece.for(King, :W, [7, 7]) }

    it 'returns false when the king is not in check' do
      expect(black_king.in_check?).to eql(false)
    end

    it 'returns true when the king is in check' do
      white_king.check = true
      expect(white_king.in_check?).to eql(true)
    end
  end

  context '#mark_checked' do
    it 'marks a king as checked after another piece moves' do
      
    end
  end

  context '#checked_move' do
    let(:checked_king) { ChessPiece.for(King, :B, [0, 0]) }
    let(:checking_rook) { ChessPiece.for(Rook, :W, [0, 1]) }

    xit 'only allows a checked king to move out of check' do

    end
  end
end
