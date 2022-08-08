# frozen_string_literal: true

require_relative '../lib/piece_movement'

# Hold values common to all chess pieces
class ChessPiece
  attr_accessor :location, :previous_location, :has_moved
  attr_reader :color

  include Movement

  BOARD_RANGE = (0..8).freeze

  def initialize(starting_location, color)
    @location = on_board(starting_location)
    @previous_location = nil
    @color = color
    @has_moved = false
  end

  def self.for(type, color, location)
    const_get(type.to_s).new(location, color)
  end

  def on_board(location)
    return location unless !BOARD_RANGE.include?(location[0]) || !BOARD_RANGE.include?(location[1])
  end
end

# Pawn specific values
class Pawn < ChessPiece
  attr_reader :symbol, :legal_moves
  attr_accessor :en_passant

  PAWN_MOVE_ONE = [[1, 0], [-1, 0]].freeze
  PAWN_MOVE_TWO = [[2, 0], [-2, 0], [1, 0], [-1, 0]].freeze

  def initialize(starting_location, color)
    super(starting_location, color)
    @symbol = color == :W ? '♙' : '♟'
    @en_passant = false
    @legal_moves = pawn_moves
  end

  private

  def pawn_moves
    possible_moves = []
    move_set = has_moved ? PAWN_MOVE_ONE : PAWN_MOVE_TWO
    move_set.each do |move|
      possible_moves << on_board([location[0] + move[0], location[1] + move[1]])
    end
    possible_moves.compact
  end
end

# King specific values
class King < ChessPiece
  attr_reader :symbol, :legal_moves
  attr_accessor :check

  KING_MOVE_ONE = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze

  def initialize(starting_location, color)
    super(starting_location, color)
    @symbol = color == :W ? '♔' : '♚'
    @legal_moves = king_moves
    @check = false
  end

  private

  def king_moves
    possible_moves = []
    KING_MOVE_ONE.each do |move|
      possible_moves << on_board([location[0] + move[0], location[1] + move[1]])
    end
    possible_moves.compact
  end
end

# Queen specific values
class Queen < ChessPiece
  attr_reader :symbol, :legal_moves

  QUEEN_MOVE = Array.new(8) { Array.new(8) }

  def initialize(starting_location, color)
    super(starting_location, color)
    @symbol = color == :W ? '♕' : '♛'
    @legal_moves = queen_moves
  end

  private

  def queen_moves
    possible_moves = []
    QUEEN_MOVE.each_with_index do |item, row|
      item.each_index do |column|
        possible_moves << on_board([location[0] + row, location[1] + column])
        possible_moves << on_board([location[0] - row, location[1] - column])
      end
    end
    possible_moves.compact.uniq
  end
end
