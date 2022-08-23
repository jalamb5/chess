# frozen_string_literal: true

require_relative '../lib/movement/piece_movement'
require_relative '../lib/piece_capture'

# Hold values common to all chess pieces
class ChessPiece
  attr_accessor :location, :previous_location, :has_moved, :captured, :last_mover
  attr_reader :color

  include Movement
  include Capture

  BOARD_RANGE = (0..7).freeze

  def initialize(starting_location, color)
    @location = on_board(starting_location)
    @previous_location = nil
    @color = color
    @has_moved = false
    @captured = false
    @last_mover = false
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
  attr_reader :symbol
  attr_accessor :en_passant, :legal_moves

  PAWN_MOVE_ONE = [[1, 0], [-1, 0]].freeze
  PAWN_MOVE_TWO = [[2, 0], [-2, 0], [1, 0], [-1, 0]].freeze
  PAWN_MOVE_DIAG  = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze

  def initialize(starting_location, color)
    super(starting_location, color)
    @symbol = color == :W ? '♙' : '♟'
    @en_passant = false
    @legal_moves = moves
  end

  def moves
    possible_moves = []
    move_set = has_moved ? PAWN_MOVE_ONE : PAWN_MOVE_TWO
    move_set.each do |move|
      possible_moves << on_board([location[0] + move[0], location[1] + move[1]])
    end
    possible_moves.compact
  end

  def diag_moves
    possible_moves = []
    PAWN_MOVE_DIAG.each do |move|
      possible_moves << on_board([location[0] + move[0], location[1] + move[1]])
    end
    possible_moves.compact
  end
end

# King specific values
class King < ChessPiece
  attr_reader :symbol
  attr_accessor :check, :legal_moves

  KING_MOVE_ONE = [[0, 1], [0, -1], [1, 0], [-1, 0]].freeze

  def initialize(starting_location, color)
    super(starting_location, color)
    @symbol = color == :W ? '♔' : '♚'
    @legal_moves = moves
    @check = false
  end

  def moves
    possible_moves = []
    KING_MOVE_ONE.each do |move|
      possible_moves << on_board([location[0] + move[0], location[1] + move[1]])
    end
    possible_moves.compact
  end
end

# Queen specific values
class Queen < ChessPiece
  attr_reader :symbol
  attr_accessor :legal_moves

  QUEEN_MOVE = Array.new(8) { Array.new(8) }

  def initialize(starting_location, color)
    super(starting_location, color)
    @symbol = color == :W ? '♕' : '♛'
    @legal_moves = moves
  end

  def moves
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

# Rook specific values
class Rook < ChessPiece
  attr_reader :symbol
  attr_accessor :legal_moves

  ROOK_MOVE = (-7..7).freeze

  def initialize(starting_location, color)
    super(starting_location, color)
    @symbol = color == :W ? '♖' : '♜'
    @legal_moves = moves
  end

  def moves
    possible_moves = []
    ROOK_MOVE.each do |move|
      # move vertically
      possible_moves << on_board([location[0] + move, location[1]])
      # move horizontally
      possible_moves << on_board([location[0], location[1] + move])
    end
    possible_moves.compact.uniq
  end
end

# Bishop specific values
class Bishop < ChessPiece
  attr_reader :symbol
  attr_accessor :legal_moves

  BISHOP_MOVE = [
    [1, 1], [-1, -1], [1, -1], [-1, 1],
    [2, 2], [-2, -2], [2, -2], [-2, 2],
    [3, 3], [-3, -3], [3, -3], [-3, 3],
    [4, 4], [-4, -4], [4, -4], [-4, 4],
    [5, 5], [-5, -5], [5, -5], [-5, 5],
    [6, 6], [-6, -6], [6, -6], [-6, 6],
    [7, 7], [-7, -7], [7, -7], [-7, 7]
  ].freeze

  def initialize(starting_location, color)
    super(starting_location, color)
    @symbol = color == :W ? '♗' : '♝'
    @legal_moves = moves
  end

  def moves
    possible_moves = []
    BISHOP_MOVE.each do |move|
      possible_moves << on_board([location[0] + move[0], location[1] + move[1]])
    end
    possible_moves.compact.uniq
  end
end

# Knight specific values
class Knight < ChessPiece
  attr_reader :symbol
  attr_accessor :legal_moves

  KNIGHT_MOVE = [[-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1], [2, 1], [1, 2]].freeze

  def initialize(starting_location, color)
    super(starting_location, color)
    @symbol = color == :W ? '♘' : '♞'
    @legal_moves = moves
  end

  def moves
    possible_moves = []
    KNIGHT_MOVE.each do |move|
      possible_moves << on_board([location[0] + move[0], location[1] + move[1]])
    end
    possible_moves.compact
  end
end
