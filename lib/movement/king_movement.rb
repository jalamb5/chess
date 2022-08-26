# frozen_string_literal: true

# King specific mixin for Movement module
module KingMovement
  def check_king(registry)
    registry.each do |piece|
      piece.check = true if piece.instance_of?(King) && piece.color != color && legal_moves.include?(piece.location)
    end
  end

  def in_check?
    check
  end

  def opp_moves(registry)
    all_opp_moves = []
    registry.each do |piece|
      all_opp_moves += piece.legal_moves unless piece.color == color
    end
    all_opp_moves
  end

  def legal_king(new_location, registry)
    opp_moves = opp_moves(registry)
    # Do not allow king to move into check
    return false if opp_moves.include?(new_location)

    legal_moves.include?(new_location)
  end
end
