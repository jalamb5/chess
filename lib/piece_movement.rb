# frozen_string_literal: true

# Mixin for chess_pieces to handle updating location and verifying move legality for a given piece
module Movement
  def move(new_location, registry)
    return 'invalid move' unless legal(new_location, registry)

    capture_piece(location_occupied(new_location, registry)) if location_occupied(new_location, registry)

    current_location = location
    self.location = new_location
    self.previous_location = current_location
    self.has_moved = true
    self.legal_moves = moves
  end

  private

  def legal(new_location, registry)
    if instance_of?(Pawn)
      pawn_rules(new_location, registry)
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

  def pawn_rules(new_location, registry)
    legal_diagonals = diag_moves
    if legal_diagonals.include?(new_location)
      return true if location_occupied(new_location, registry) || en_passant
    else
      legal_moves.include?(new_location)
    end
  end
end
