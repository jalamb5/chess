# frozen_string_literal: true

# Mixin for chess_pieces to handle updating location and verifying move legality for a given piece
module Movement
  def move(new_location)
    current_location = location
    self.location = new_location
    self.previous_location = current_location
  end
end
