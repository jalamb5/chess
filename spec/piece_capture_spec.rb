# frozen_string_literal: true

require_relative '../lib/piece_capture'
require_relative '../lib/chess_pieces'

describe Capture do
  context '#capture_piece' do
    let(:capturing_pawn) { Pawn.new([0, 1], :W) }
    let(:captured_pawn) { Pawn.new([1, 1], :B) }
    let(:registry) { [capturing_pawn, captured_pawn] }

    it 'marks a piece as captured' do
      capturing_pawn.move([1, 1], registry)
      expect(captured_pawn.location).to eq(:Captured)
    end
  end
end
