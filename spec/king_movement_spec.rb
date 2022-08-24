# frozen_string_literal: true

require_relative '../lib/movement/king_movement'
require_relative '../lib/movement/piece_movement'
require_relative '../lib/chess_pieces'

describe KingMovement do
  context '#' do
    let(:black_king) { ChessPiece.for(King, :B, [0, 0]) }
    let(:white_king) { ChessPiece.for(King, :W, [7, 7]) }
    let(:registry) { [black_king, white_king] }

    xit 'determines if a king is in check' do
      
    end
  end
end
