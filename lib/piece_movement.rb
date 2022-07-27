# frozen_string_literal: true

# Mixin for chess_pieces to handle updating location and verifying move legality for a given piece
module Movement
  def move(new_location)
    return unless legal(new_location)

    current_location = location
    self.location = new_location
    self.previous_location = current_location
    self.has_moved = true
  end

  private

  def legal(new_location)
    # retrieve legal moveset from piece
    # check new_location against possible legal moves
    # return false if the move is illegal
    true
  end
end
