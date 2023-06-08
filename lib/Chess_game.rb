require './lib/Chess.rb'
require './lib/Pieces.rb'

chess = Chess.new()
# start game
chess.intro_str

# game_loop
chess.game_loop

# game_over
chess.game_ends