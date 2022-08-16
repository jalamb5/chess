# frozen_string_literal: true

require_relative '../lib/piece_capture'
require_relative '../lib/chess_pieces'

describe Capture do
  context '#capture_piece' do
    let(:capturing_pawn) { Pawn.new([0, 1], :W) }
    let(:captured_pawn) { Pawn.new([0, 2], :B) }

    xit 'removes a captured piece from the game' do
      capturing_pawn.move([0, 2])
      expect(captured_pawn.location).to eq(:Captured)
    end
  end
end
