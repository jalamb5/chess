# frozen_string_literal: true

# Handle capturing of pieces and removing them from the game.
module Capture
  def capture_piece(captured_piece)
    captured_piece.captured = true unless color == captured_piece.color
  end
end
