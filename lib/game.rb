# frozen_string_literal: true

require_relative '../lib/chess_board'
require_relative '../lib/chess_pieces'

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
    color = 'White'

    until game_over
      piece_location = select_location(color)
      piece = piece_lookup(piece_location)
      move_location = select_location
      piece.move(move_location, registry)
      chess_board.update_board(piece)
      puts chess_board.pretty_print

      color = color == 'White' ? 'Black' : 'White'
    end
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
      'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7,
      '1' => 7, '2' => 6, '3' => 5, '4' => 4, '5' => 3, '6' => 2, '7' => 1, '8' => 0
    }
    parsed_location = []

    location.each do |value|
      return 'invalid selection' unless input_mapper[value]

      parsed_location << input_mapper[value]
    end

    parsed_location.reverse
  end

  def select_location(color = nil)
    location = []

    puts "#{color}: Select a piece to move." unless color.nil?
    puts 'Move the piece to where?' if color.nil?
    puts 'Choose column: [a-h] '
    location << gets.chomp
    puts 'Choose row: [1-8] '
    location << gets.chomp.to_s
    input_validator(location)
  end

  def piece_lookup(location)
    registry.each do |piece|
      return piece if piece.location == location
    end
  end
end

# Game.new.play
