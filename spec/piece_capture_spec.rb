# frozen_string_literal: true

require_relative '../lib/piece_capture'
require_relative '../lib/chess_pieces'

describe Capture do
  context '#capture_piece' do
    let(:capturing_rook) { Rook.new([0, 1], :W) }
    let(:captured_rook) { Rook.new([1, 1], :B) }
    let(:capturing_pawn) { Pawn.new([5, 5], :W) }
    let(:captured_pawn) { Pawn.new([6, 6], :B) }
    let(:registry) { [capturing_rook, captured_rook, capturing_pawn, captured_pawn] }

    it 'marks a piece as captured' do
      capturing_rook.move([1, 1], registry)
      expect(captured_rook.captured).to eq(true)
    end

    it 'allows a pawn to captured diagonally' do
      capturing_pawn.move([6, 6], registry)
      expect(captured_pawn.captured).to eq(true)
    end
  end
end
