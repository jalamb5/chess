# frozen_string_literal: true

require_relative '../lib/chess_board'

# Generate objects needed for game and gameloop
class Game
  attr_accessor :chess_board, :registry

  NEW_GAME_LOCATIONS = [
    [[7, 4], King, :W],
    [[0, 4], King, :B],
    [[7, 3], Queen, :W],
    [[0, 3], Queen, :B],
    [[7, 0], Rook, :W],
    [[0, 0], Rook, :B],
    [[7, 7], Rook, :W],
    [[0, 7], Rook, :B],
    [[7, 2], Bishop, :W],
    [[0, 2], Bishop, :B],
    [[7, 5], Bishop, :W],
    [[0, 5], Bishop, :B],
    [[7, 1], Knight, :W],
    [[0, 1], Knight, :B],
    [[7, 6], Knight, :W],
    [[0, 6], Knight, :B]
  ].freeze

  def initialize
    @chess_board = ChessBoard.new
    @registry = []
    fill_board
    # puts "\n#{chess_board.pretty_print}"
  end

  def play
    puts "Welcome to Chess.\n#{chess_board.pretty_print}\nWhite goes first"
    game_loop
    puts "#{game_over.color} has no legal moves."
    puts 'Thanks for playing.'
  end

  private

  def fill_board
    fill_row(6, Pawn, :W)
    fill_row(1, Pawn, :B)
    NEW_GAME_LOCATIONS.each { |piece| add_piece(piece[0], piece[1], piece[2]) }
  end

  def fill_row(row, piece_type, color)
    chess_board.board[row].each_with_index do |_item, column|
      piece = ChessPiece.for(piece_type, color, [row, column])
      registry << piece
      chess_board.board[row][column] = piece.symbol
    end
  end

  def add_piece(location, piece_type, color)
    piece = ChessPiece.for(piece_type, color, location)
    registry << piece
    chess_board.board[location[0]][location[1]] = piece.symbol
  end

  def game_loop
    return if game_over

    color = 'White'

    puts "#{color}: Select a piece to move."
    puts 'Choose column: [a-h] '
    column = gets.chomp
    input_validator(column)
    puts 'Choose row: [1-8] '
    row = gets.chomp
    input_validator(row)
  end

  def king_in_check
    check = []
    registry.each do |piece|
      check << piece if piece.instance_of?(King)
    end
    if check[0].check == true || check[1].check == true
      check
    else
      false
    end
  end

  def game_over
    return unless king_in_check

    kings = king_in_check
    kings.each do |king|
      return king if king.legal_moves.nil?
    end
  end

  # convert user-friendly input options to zero indexed values
  def input_validator(location)
    input_mapper = {
      'a': 0, 'b': 1, 'c': 2, 'd': 3, 'e': 4, 'f': 5, 'g': 6, 'h': 7,
      '1': 0, '2': 1, '3': 2, '4': 3, '5': 4, '6': 5, '7': 6, '8': 7
    }
    return 'invalid selection' unless input_mapper[location]

    input_mapper[location]
  end
end
