# frozen_string_literal: true

# Mixin for chess_pieces to handle updating location and verifying move legality for a given piece
module Movement
  def move(new_location, registry)
    return 'invalid move' unless legal(new_location)

    capture_piece(location_occupied(new_location, registry)) if location_occupied(new_location, registry)
    current_location = location
    self.location = new_location
    self.previous_location = current_location
    self.has_moved = true
  end

  private

  def legal(new_location)
    # retrieve legal moveset from piece
    # check new_location against possible legal moves
    legal_moves.include?(new_location)
    # return false if the move is illegal
  end

  def location_occupied(new_location, registry)
    registry.each do |piece|
      return piece if piece.location == new_location
    end
    false
  end
end
