# frozen_string_literal: true

# Mixin for chess_pieces to handle updating location and verifying move legality for a given piece
module Movement
  def move(new_location, registry)
    return 'invalid move' unless legal(new_location, registry)

    capture_piece(location_occupied(new_location, registry)) if location_occupied(new_location, registry)
    capture_piece(legal_en_passant(registry)) if legal_en_passant(registry) # TODO: check that new location is the loc directly behind the en passant pawn

    current_location = location
    self.location = new_location
    self.previous_location = current_location
    mark_en_passant(registry) if instance_of?(Pawn)
    self.has_moved = true
    self.legal_moves = moves
    self.last_mover = true
  end

  private

  def legal(new_location, registry)
    if instance_of?(Pawn)
      legal_pawn(new_location, registry)
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

  def legal_pawn(new_location, registry)
    legal_diagonals = diag_moves
    if legal_diagonals.include?(new_location)
      return true if location_occupied(new_location, registry) || legal_en_passant(registry)
    else
      legal_moves.include?(new_location) unless location_occupied(new_location, registry)
    end
  end

  def legal_en_passant(registry)
    registry.each do |piece|
      next unless piece.last_mover && piece.instance_of?(Pawn)
      return piece if piece.en_passant
    end
    false
  end

  def mark_en_passant(registry)
    registry.each do |piece|
      piece.en_passant = false if piece.instance_of?(Pawn)
    end
    self.en_passant = true if (location[0] - previous_location[0]).abs == 2
  end
end
