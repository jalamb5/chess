# frozen_string_literal: true

class ChessBoard
  attr_accessor :board

  def initialize
    @board = '
       _______________
    8 |_|_|_|_|_|_|_|_|
    7 |_|_|_|_|_|_|_|_|
    6 |_|_|_|_|_|_|_|_|
    5 |_|_|_|_|_|_|_|_|
    4 |_|_|_|_|_|_|_|_|
    3 |_|_|_|_|_|_|_|_|
    2 |_|_|_|_|_|_|_|_|
    1 |_|_|_|_|_|_|_|_|
       a b c d e f g h
    '
  end
end
