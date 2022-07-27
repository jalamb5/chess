# frozen_string_literal: true

# Hold values common to all chess pieces
class ChessPiece
  attr_accessor :location, :previous_location
  attr_reader :color

  include Movement

  def initialize(starting_location, color)
    @location = starting_location
    @previous_location = nil
    @color = color
  end

  def self.for(type, color, location)
    const_get(type.to_s).new(location, color)
  end
end

# Pawn specific values
class Pawn < ChessPiece
  attr_reader :symbol
  attr_accessor :en_passant

  def initialize(starting_location, color)
    super(starting_location, color)
    @symbol = 'P'
    @en_passant = false
  end
end
