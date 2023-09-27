require_relative 'ChessGame'

chess_game = ChessGame.new

chess_game.game_start
chess_game.game_loop
chess_game.game_ends

# bugs
# king can be taken, which breaks the game
# solution: when check happens, do not allow the player to make any moves which do not move the king out of the way.

# king_escapes should know these, so it can provide these back to be used