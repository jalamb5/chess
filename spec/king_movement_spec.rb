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

  context '#opp_moves' do
    let(:white_pawn) { ChessPiece.for(Pawn, :W, [1, 1]) }
    let(:black_king) { ChessPiece.for(King, :B, [0, 0]) }
    let(:white_pawn_legal_moves) { [[3, 1], [2, 1], [0, 1]] }
    let(:registry) { [white_pawn, black_king] }

    it 'creates a list of legal moves of all opponent pieces' do
      expect(black_king.opp_moves(registry)).to eql(white_pawn_legal_moves)
    end
  end

  context '#checked_move' do
    let(:checked_king) { ChessPiece.for(King, :B, [0, 0]) }
    let(:checking_rook) { ChessPiece.for(Rook, :W, [1, 1]) }
    let(:registry) { [checked_king, checking_rook] }

    it 'only allows a checked king to move out of check' do
      checking_rook.move([0, 1], registry)
      expect(checked_king.move([1, 1], registry)).to eq('invalid move')
    end
  end
end
