# frozen_string_literal: true

# Hold values common to all chess pieces
class ChessPiece
  attr_accessor :location

  def initialize(starting_location)
    @location = starting_location
  end
end

# Pawn specific values
class Pawn < ChessPiece
  attr_reader :symbol

  def initialize(starting_location)
    super(starting_location)
    @symbol = 'P'
  end
end
