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
    let(:pawn) { described_class.new([0, 2], :W) }
    let(:black_pawn) { described_class.new([0, 2], :B) }
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
    let(:white_king) { described_class.new([0, 2], :W) }
    let(:black_king) { described_class.new([1, 2], :B) }
    let(:king_moves) { [[0, 3], [0, 1], [1, 2]] }

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

      it 'is not in check' do
        expect(white_king.check).to eq false
      end
    end
  end

  describe Queen do
    let(:white_queen) { described_class.new([0, 2], :W) }
    let(:black_queen) { described_class.new([1, 2], :B) }
    let(:queen_moves) { [[0, 2], [0, 3], [0, 1], [0, 4], [0, 0], [0, 5], [0, 6], [0, 7], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [2, 2], [2, 3], [2, 4], [2, 5], [2, 6], [2, 7], [3, 2], [3, 3], [3, 4], [3, 5], [3, 6], [3, 7], [4, 2], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7], [5, 2], [5, 3], [5, 4], [5, 5], [5, 6], [5, 7], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7]] }

    context '#initialize' do
      it 'displays "♔" symbol for white queen' do
        expect(white_queen.symbol).to eq '♕'
      end

      it 'displays "♚" symbol for black queen' do
        expect(black_queen.symbol).to eq '♛'
      end

      it 'can update its location' do
        white_queen.location = [1, 2]
        expect(white_queen.location).to eq [1, 2]
      end

      it 'generates a list of legal moves' do
        expect(white_queen.legal_moves).to eq queen_moves
      end
    end
  end

  describe Rook do
    let(:white_rook) { described_class.new([0, 2], :W) }
    let(:black_rook) { described_class.new([1, 2], :B) }
    let(:rook_moves) { [[0, 0], [0, 1], [0, 2], [1, 2], [0, 3], [2, 2], [0, 4], [3, 2], [0, 5], [4, 2], [0, 6], [5, 2], [0, 7], [6, 2], [7, 2]] }

    context '#initialize' do
      it 'displays "♖" symbol for white rook' do
        expect(white_rook.symbol).to eq '♖'
      end

      it 'displays "♜" symbol for black rook' do
        expect(black_rook.symbol).to eq '♜'
      end

      it 'generates a list of legal moves' do
        expect(white_rook.legal_moves).to eq rook_moves
      end
    end
  end

  describe Bishop do
    let(:white_bishop) { described_class.new([0, 2], :W) }
    let(:black_bishop) { described_class.new([1, 2], :B) }
    let(:bishop_moves) { [[1, 3], [1, 1], [2, 4], [2, 0], [3, 5], [4, 6], [5, 7]] }

    context '#initialize' do
      it 'displays "♗" symbol for white bishop' do
        expect(white_bishop.symbol).to eq '♗'
      end

      it 'displays "♝" symbol for black bishop' do
        expect(black_bishop.symbol).to eq '♝'
      end

      it 'generates a list of legal moves' do
        expect(white_bishop.legal_moves).to eq bishop_moves
      end
    end
  end

  describe Knight do
    let(:white_knight) { described_class.new([0, 2], :W) }
    let(:black_knight) { described_class.new([1, 2], :B) }
    let(:knight_moves) { [[1, 0], [2, 1], [2, 3], [1, 4]] }

    context '#initialize' do
      it 'displays "♘" symbol for white knight' do
        expect(white_knight.symbol).to eq '♘'
      end

      it 'displays "♞" symbol for black knight' do
        expect(black_knight.symbol).to eq '♞'
      end

      it 'generates a list of legal moves' do
        expect(white_knight.legal_moves).to eq knight_moves
      end
    end
  end
end
