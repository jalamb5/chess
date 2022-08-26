# frozen_string_literal: true

require_relative './pawn_movement'
require_relative './king_movement'

# Mixin for chess_pieces to handle updating location and verifying move legality for a given piece
module Movement
  include PawnMovement
  include KingMovement

  def move(new_location, registry)
    return 'invalid move' unless legal(new_location, registry)

    capture_piece(location_occupied(new_location, registry)) if location_occupied(new_location, registry)
    capture_piece(capture_en_passant(new_location, registry)) if capture_en_passant(new_location, registry)

    update_attrs(new_location, registry)
  end

  private

  def update_attrs(new_location, registry)
    current_location = location
    self.location = new_location
    self.previous_location = current_location
    mark_en_passant(registry) if instance_of?(Pawn)
    self.has_moved = true
    self.legal_moves = moves
    check_king(registry)
    self.last_mover = true
  end

  def legal(new_location, registry)
    if instance_of?(Pawn)
      legal_pawn(new_location, registry)
    elsif instance_of?(King)
      legal_king(new_location, registry)
    else
      legal_moves.include?(new_location)
    end
  end

  def location_occupied(new_location, registry)
    registry.each do |piece|
      return piece if piece.location == new_location
    end
    false
  end
end
