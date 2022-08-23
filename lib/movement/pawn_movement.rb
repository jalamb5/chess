# frozen_string_literal: true

# Pawn specific mixin for Movement module
module Pawn_Movement
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

  def capture_en_passant(new_location, registry)
    piece_to_capture = legal_en_passant(registry)
    return piece_to_capture if piece_to_capture == false

    if piece_to_capture.color == :B
      return piece_to_capture if piece_to_capture.location[0] - new_location[0] == 1 && piece_to_capture.location[1] == new_location[1]
    else
      return piece_to_capture if piece_to_capture.location[0] + new_location[0] == 1 && piece_to_capture.location[1] == new_location[1]
    end
    false
  end
end