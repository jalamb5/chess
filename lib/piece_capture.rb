# frozen_string_literal: true

# Handle capturing of pieces and removing them from the game.
module Capture
  def capture_piece(captured_piece)
    capture_piece.location == :Captured
  end
end
