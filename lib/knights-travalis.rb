require_relative 'Board'
require_relative 'Knight'

knight = Knight.new()
board = Board.new([8, 8])

p board.piece_moves(knight.possible_moves, [0, 0], [8, 8])

