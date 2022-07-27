# frozen_string_literal: true

require_relative '../lib/piece_movement'

# Hold values common to all chess pieces
class ChessPiece
  attr_accessor :location, :previous_location, :has_moved
  attr_reader :color

  include Movement

  def initialize(starting_location, color)
    @location = starting_location
    @previous_location = nil
    @color = color
    @has_moved = false
  end

  def self.for(type, color, location)
    const_get(type.to_s).new(location, color)
  end
end

# Pawn specific values
class Pawn < ChessPiece
  attr_reader :symbol, :legal_moves
  attr_accessor :en_passant

  def initialize(starting_location, color)
    super(starting_location, color)
    @symbol = 'P'
    @en_passant = false
    @legal_moves = pawn_moves
  end

  private

  def pawn_moves
    has_moved ? [location[0], location[1] + 1] : [[location[0], location[1] + 1], [location[0], location[1] + 2]]
  end
end
