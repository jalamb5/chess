# frozen_string_literal: true

# King specific mixin for Movement module
module KingMovement
  def in_check?
    check
  end
end
