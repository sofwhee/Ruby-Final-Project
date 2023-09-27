require './lib/ChessGame.rb'

describe ChessGame do

  let(:piece_tester) { Pieces.new }
  let(:board_tester) { ChessBoard.new }
  let(:referee_tester) { ChessReferee.new }
  subject(:chess_game_tester) { ChessGame.new(board_tester, piece_tester, referee_tester) }

  # describe '#initialize' do
  # end

  # describe '#set_pieces' do

  #   context 'when called' do
  #     before do
  #       allow(board_tester).to receive(:add_piece).and_return(nil)
  #       allow(piece_tester).to receive(:create).and_return(nil)
  #     end

  #     it 'calls add_piece on @board and create @pieces 32 times' do
  #       expect(board_tester).to receive(:add_piece).exactly(32).times
  #       expect(piece_tester).to receive(:create).exactly(32).times
  #       chess_game_tester.set_pieces
  #     end

  #     it 'calls add_piece on @board and create @pieces 32 times' do
  #       expect(board_tester).to receive(:add_piece).exactly(32).times
  #       expect(piece_tester).to receive(:create).exactly(32).times
  #       chess_game_tester.set_pieces
  #     end
  #   end

  #   context 'when called' do
  #     it 'makes a8 the black rook' do
  #       chess_game_tester.set_pieces
  #       name = board_tester.get_square("a", 8).piece.name
  #       side = board_tester.get_square("a", 8).piece.side
  #       expect("#{side} #{name}").to eq("black rook")
  #     end

  #     it 'makes e8 the black king' do
  #       chess_game_tester.set_pieces
  #       name = board_tester.get_square("e", 8).piece.name
  #       side = board_tester.get_square("e", 8).piece.side
  #       expect("#{side} #{name}").to eq("black king")
  #     end

  #     it 'makes e1 the white king' do
  #       chess_game_tester.set_pieces
  #       name = board_tester.get_square("e", 1).piece.name
  #       side = board_tester.get_square("e", 1).piece.side
  #       expect("#{side} #{name}").to eq("white king")
  #     end
  #   end
  # end

  # describe '#start_turn' do
  # end

  # describe '#take_input_and_clean' do
    
  #   context 'when given "A4, B6" as gets output' do

  #     before do
  #       allow(chess_game_tester).to receive(:gets).and_return("A4, B6")
  #     end

  #     it 'returns "a4 b6"' do
  #       expect(chess_game_tester.take_input_and_clean).to eq("a4 b6")
  #     end
  #   end
    
  #   context 'when given "a5, b6" as gets output' do

  #     before do
  #       allow(chess_game_tester).to receive(:gets).and_return("a5, b6")
  #     end

  #     it 'returns "a5 b6"' do
  #       expect(chess_game_tester.take_input_and_clean).to eq("a5 b6")
  #     end
  #   end

  #   context 'when given "a8b6" as gets output' do

  #     before do
  #       allow(chess_game_tester).to receive(:gets).and_return("a8b6")
  #     end

  #     it 'returns "a8b6"' do
  #       expect(chess_game_tester.take_input_and_clean).to eq("a8b6")
  #     end
  #   end
  # end

  # describe '#coords_in_string' do
    
  #   let(:test_str) { "b2 d4" }
  #   let(:result_coords) { ["b2", "d4"] }

  #   context 'when passed "b2 d4"' do
  #     it 'returns ["b2", "d4"]' do
  #       expect(chess_game_tester.coords_in_string(test_str)).to eq(result_coords)
  #     end
  #   end
    
  #   context 'when passed "Move b2 d4"' do
  #     it 'returns ["b2", "d4"]' do
  #     end
  #   end

  #   context 'when passed "Move b2 to d4"' do
  #     it 'returns ["b2", "d4"]' do
  #     end
  #   end

  #   context 'when passed "b2d4"' do
  #     it 'returns nil' do
  #     end
  #   end
  # end

  # describe '#extract_coords' do
  #   context 'a4 b6' do
  #     let(:input) { 'a4 b6' }
  #     let(:coord1) { ['a', '4'] }
  #     let(:coord2) { ['b', '6'] }

  #     it 'returns [["a", "4"], ["b", "6"]]' do
  #       expect(chess_game_tester.extract_coords(input)).to eq([coord1, coord2])
  #     end
  #   end

  #   context 'q4 b6' do
  #     let(:input) { 'q4 b6' }

  #     it 'returns nil' do
  #       expect(chess_game_tester.extract_coords(input)).to be nil
  #     end
  #   end

  #   context 'a12 b6' do
  #     let(:input) { 'a12 b6' }

  #     it 'returns nil' do
  #       expect(chess_game_tester.extract_coords(input)).to be nil
  #     end
  #   end

  #   context 'a9 b6' do
  #     let(:input) { 'a9 b6' }

  #     it 'returns nil' do
  #       expect(chess_game_tester.extract_coords(input)).to be nil
  #     end
  #   end

  #   context 'cc be' do
  #     let(:input) { 'cc be' }

  #     it 'returns nil' do
  #       expect(chess_game_tester.extract_coords(input)).to be nil
  #     end
  #   end

  #   context '44 67' do
  #     let(:input) { '44 67' }

  #     it 'returns nil' do
  #       expect(chess_game_tester.extract_coords(input)).to be nil
  #     end
  #   end
  # end

  # describe '#move_path_tree' do
  #   context 'when the root square is [a, 1] and is given a black pawns moves' do
      
  #     let(:black_pawn)  { Pawn.new }
  #     let(:root_square) { instance_double(
  #       Square, data: ['a', '1'], piece: black_pawn, children: [], parent: nil) }

  #     before do
  #       allow(root_square).to receive(:has_parent?).and_return(false)
  #     end

  #     it 'adds one to children' do
  #       expect { chess_game_tester.move_path_tree(root_square, "black") }.to \
  #       change { root_square.children.size }.by(1) 
  #     end

  #     it 'the root squares children will equal [[a, 2]]' do
  #       chess_game_tester.move_path_tree(root_square, "black")
  #       expect(root_square.children[0].data).to eq(['a', '2'])
  #     end
  #   end
  # end

  # describe '#checking_squares' do
    
  #   let(:king_square) { instance_double(Square, data: ["d", "4"], piece: King.new("white")) }
  #   let(:rook_square) { instance_double(Square, data: ["d", "8"], piece: Rook.new()) }
    
  #   let(:friendly_squares) { [rook_square] }

  #   let(:result) { friendly_squares }

  #   context 'when given a square with a white king at d4 and a square with a black rook at d8' do
  #     it 'returns the square with the black rook' do
  #       expect(chess_game_tester.checking_squares(king_square, friendly_squares)).to eq(result)
  #     end
  #   end

  #   let(:queen_square) { instance_double(Square, data: ["b", "2"], piece: Queen.new()) }

  #   let(:friendly_squares) { [rook_square, queen_square] }  
  #   let(:result) { friendly_squares }

  #   context 'when the same conditions apply but there is also a black queen at b2' do
  #     it 'returns a list of squares for the black rook and black queen' do
  #       expect(chess_game_tester.checking_squares(king_square, friendly_squares)).to eq(result)
  #     end
  #   end
  # end

  # describe '#check_message' do

  #   let(:rook_square) { instance_double(
  #     Square, data: ["d", "8"], piece: Rook.new()) }
  #   let(:queen_square) { instance_double(
  #     Square, data: ["b", "2"], piece: Queen.new()) }
    
  #   let(:checking_squares) { [rook_square, queen_square] }

  #   let(:result) { 'white\'s king has been checked by a black rook at ["d", "8"], a black queen at ["b", "2"].' }

  #   context 'when given squares with pieces [black rook, black queen]' do
  #     it 'returns correct string' do
  #       chess_game_tester.switch_player
  #       expect(chess_game_tester.check_message(checking_squares)).to eq(result)
  #     end
  #   end
  # end

  # describe '#checking_pieces_string' do
  # end

  # describe '#check?' do  
    
  #   let(:check_board) { ChessBoard.new }
  #   let(:chess_game_tester) { ChessGame.new(check_board, piece_tester, referee_tester) }
  #   let(:player) { "white" }

  #   before do
  #     allow(chess_game_tester).to receive(:puts)
  #   end

  #   context 'when the king can be taken in one move by any piece on the board' do
  #     it 'returns true' do
  #       chess_game_tester.switch_player
  #       check_board.add_piece('e', 8, King.new("black"))
  #       check_board.add_piece('e', 4, Rook.new("white"))
  #       expect(chess_game_tester.check?).to_not be false
  #     end
  #   end

  #   context 'when the king is not under threat' do
  #     it 'returns false' do
  #       check_board.add_piece('e', 1, King.new("black"))
  #       check_board.add_piece('d', 4, Rook.new("white"))
  #       expect(chess_game_tester.check?).to be false
  #     end
  #   end
  # end

  # describe '#make_sq_double' do

  #   let(:square_test) { instance_double(Square, data: ["a", "4"], piece: Knight.new())}

  #   it 'creates a new Square with the same .data' do
  #     double = chess_game_tester.make_sq_double(square_test)
  #     expect(double.data).to eq(square_test.data)
  #   end

  #   it 'creates a new Square with the same .piece' do
  #     double = chess_game_tester.make_sq_double(square_test)
  #     expect(double.piece).to eq(square_test.piece)
  #   end
  # end

  # describe '#king_escapes' do

  #   let(:king)        { King.new("white") }

  #   before do
  #     board_tester.clear_board
  #     allow(chess_game_tester).to receive(:puts)
  #     allow(board_tester).to receive(:puts)
  #   end
    
  #   context 'when the king is at d4 and there are no other pieces' do

  #     start_location = ['d', 4]
  #     result = [['d', '5'], ['e', '5'], ['e', '4'], ['e', '3'], ['d', '3'], ['c', '3'], ['c', '4'], ['c', '5']]
      
  #     it 'returns all 8 possible directions' do
  #       chess_game_tester.switch_player
  #       board_tester.add_piece(start_location[0], start_location[1], king)

  #       king_square = board_tester.get_square(start_location[0], start_location[1])
  #       king_move_squares = chess_game_tester.king_escapes(king_square)

  #       king_move_coords = king_move_squares.map { |sq| sq.data }
  #       king_move_coords = king_move_coords - result

  #       expect(king_move_coords.empty?).to_not eq(false)
  #     end
  #   end

  #   context 'when the king is at a1 and there are no other pieces' do

  #     result = [['a', '2'], ['b', '2'], ['b', '1']]
  #     start_location = ['a', 1]

  #     it 'returns all 3 possible directions' do
  #       board_tester.add_piece(start_location[0], start_location[1], king)

  #       king_square = board_tester.get_square(start_location[0], start_location[1])
  #       king_move_squares = chess_game_tester.king_escapes(king_square)

  #       king_move_coords = king_move_squares.map { |sq| sq.data }
  #       king_move_coords = king_move_coords - result

  #       expect(king_move_coords.empty?).to_not eq(false)
  #     end
  #   end

  #   context 'when the king is at a8 and there are no other pieces' do

  #     result = [['a', '7'], ['b', '7'], ['b', '8']]
  #     start_location = ['a', 8]

  #     it 'returns all 3 possible directions' do
  #       board_tester.add_piece(start_location[0], start_location[1], king)

  #       king_square = board_tester.get_square(start_location[0], start_location[1])
  #       king_move_squares = chess_game_tester.king_escapes(king_square)

  #       king_move_coords = king_move_squares.map { |sq| sq.data }
  #       king_move_coords = king_move_coords - result

  #       expect(king_move_coords.empty?).to_not eq(false)
  #     end
  #   end

  #   context 'when the king is at a1 and there is a friendly piece at b2' do

  #     result = [['a', '2'], ['b', '1']]
  #     start_location = ['a', 1]
  #     let(:knight)        { Knight.new("white") }

  #     it 'returns all 2 possible directions' do
  #       board_tester.add_piece(start_location[0], start_location[1], king)
  #       board_tester.add_piece('b', 2, knight)

  #       king_square = board_tester.get_square(start_location[0], start_location[1])
  #       king_move_squares = chess_game_tester.king_escapes(king_square)

  #       king_move_coords = king_move_squares.map { |sq| sq.data }
  #       king_move_coords = king_move_coords - result

  #       expect(king_move_coords.empty?).to_not eq(false)
  #     end
  #   end

  #   context 'when the king is at a1 and there is an enemy piece at b2' do

  #     result = [['a', '2'], ['b', '2'], ['b', '1']]
  #     start_location = ['a', 1]
  #     let(:knight)        { Knight.new("black") }

  #     it 'returns all 3 possible directions' do
  #       board_tester.add_piece(start_location[0], start_location[1], king)
  #       board_tester.add_piece('b', 2, knight)

  #       king_square = board_tester.get_square(start_location[0], start_location[1])
  #       king_move_squares = chess_game_tester.king_escapes(king_square)

  #       king_move_coords = king_move_squares.map { |sq| sq.data }
  #       king_move_coords = king_move_coords - result

  #       expect(king_move_coords.empty?).to_not eq(false)
  #     end
  #   end

  #   context 'when the king is at a1 and there is are pieces in all three directions' do

  #     result = []
  #     start_location = ['a', 1]
  #     let(:knight)         { Knight.new("white") }
  #     let(:knight2)        { Knight.new("white") }
  #     let(:knight3)        { Knight.new("white") }

  #     it 'returns no possible directions' do
  #       board_tester.add_piece(start_location[0], start_location[1], king)
  #       board_tester.add_piece('a', 2, knight)
  #       board_tester.add_piece('b', 2, knight2)
  #       board_tester.add_piece('b', 1, knight)

  #       king_square = board_tester.get_square(start_location[0], start_location[1])
  #       king_move_squares = chess_game_tester.king_escapes(king_square)

  #       king_move_coords = king_move_squares.map { |sq| sq.data }
  #       king_move_coords == result

  #       expect(king_move_coords == result).to_not eq(false)
  #     end
  #   end
  # end

  # describe '#checkmate' do

  #   let(:check_board) { ChessBoard.new }
  #   let(:chess_game_tester) { ChessGame.new(check_board, piece_tester, referee_tester) }
  #   let(:player) { "white" }

  #   context 'when the king has no way of escaping check' do
  #     it 'returns true' do
  #       chess_game_tester.switch_player
  #       check_board.add_piece('e', 1, King.new("black"))
  #       check_board.add_piece('d', 4, Rook.new("white", "left rook"))
  #       check_board.add_piece('e', 4, Rook.new("white", "middle rook"))
  #       check_board.add_piece('f', 4, Rook.new("white", "right rook"))
  #       expect(chess_game_tester.checkmate?).to be true
  #     end
  #   end

  #   context 'when the king has no way of escaping check' do
  #     it 'returns true' do
  #       check_board.clear_board
  #       check_board.add_piece('d', 8, King.new("black"))
  #       check_board.add_piece('a', 8, Rook.new("white", "left rook"))
  #       check_board.add_piece('e', 4, Rook.new("white", "right rook"))
  #       check_board.add_piece('f', 5, Bishop.new("white", "right bishop"))
  #       check_board.add_piece('c', 5, Queen.new("white"))
  #       expect(chess_game_tester.checkmate?).to be true
  #     end
  #   end

  #   context 'when the king has no way of escaping check' do
  #     it 'returns true' do
  #       check_board.clear_board
  #       check_board.add_piece('d', 8, King.new("black"))
  #       check_board.add_piece('d', 7, Pawn.new("black"))
  #       check_board.add_piece('a', 8, Rook.new("white", "left rook"))
  #       check_board.add_piece('e', 4, Rook.new("white", "right rook"))
  #       check_board.add_piece('c', 5, Queen.new("white"))
  #       expect(chess_game_tester.checkmate?).to be true
  #     end
  #   end

  #   context 'when the king is only in check' do
  #     it 'returns false' do
  #       check_board.add_piece('e', 1, King.new("black"))
  #       check_board.add_piece('e', 4, Rook.new("white", "left rook"))
  #       expect(chess_game_tester.checkmate?).to be false
  #     end
  #   end
  # end

  # describe 'game_start' do
  # end

  # describe '#game_loop' do

  #   before do
  #     # allow(chess_game_tester).to receive(:puts)
  #   end

  #   context 'When three moves made and then quit' do
        
  #     let(:moves) { ["a2 a3", "a7 a6", "a3 a4"] }

  #     before do
  #       chess_game_tester.game_start
  #       allow(chess_game_tester).to receive(:take_input_and_clean).and_return(moves[0], moves[1], moves[2], "quit")
  #     end

  #     it 'loops four times' do
  #       expect(chess_game_tester).to receive(:take_input_and_clean).exactly(4).times
  #       chess_game_tester.game_start
  #       chess_game_tester.game_loop
  #     end

  #   end

  #   context 'When black pawn is taken by white, and then quits' do
      
  #     let(:move) { "b4 a5" }
  #     let(:bl_pawn) { Pawn.new() }
  #     let(:wh_pawn) { Pawn.new("white")}

  #     before do
  #       chess_game_tester.game_start
  #       allow(chess_game_tester).to receive(:take_input_and_clean).and_return(move, "quit")
  #     end

  #     it 'move twice and then quits' do
  #       expect(chess_game_tester).to receive(:take_input_and_clean).exactly(2).times
  #       chess_game_tester.switch_player
  #       chess_game_tester.game_start
  #       board_tester.add_piece("a", 5, bl_pawn)
  #       board_tester.add_piece("b", 4, wh_pawn)
  #       chess_game_tester.game_loop
  #     end

  #     it 'replaces black pawn with white pawn' do
  #       chess_game_tester.switch_player
  #       chess_game_tester.game_start
  #       board_tester.add_piece("a", 5, bl_pawn)
  #       board_tester.add_piece("b", 4, wh_pawn)
  #       chess_game_tester.game_loop
  #       destination_sq = board_tester.get_square('a', 5)
  #       expect(destination_sq.piece).to eq(wh_pawn)
  #     end
  #   end

  #   context 'When moving rook while there is a piece in the way, then quits' do
      
  #     let(:move) { "a1 a5" }

  #     before do
  #       chess_game_tester.game_start
  #       allow(chess_game_tester).to receive(:take_input_and_clean).and_return(move, "quit")
  #     end

  #     it 'error, then quits' do
  #       expect(chess_game_tester).to receive(:take_input_and_clean).exactly(2).times
  #       expect(board_tester).to_not receive(:move_piece)
  #       chess_game_tester.switch_player
  #       chess_game_tester.game_start
  #       chess_game_tester.game_loop
  #     end
  #   end

  #   context 'When white player checks black then quits' do
  #     let(:board_tester) { ChessBoard.new }
      
  #     let(:white_king)   { King.new("white") }
  #     let(:white_rook)   { Rook.new("white") }

  #     let(:black_king)   { King.new("black") }
  #     let(:black_pawn)   { Pawn.new("black") }

  #     let(:move) { "a7 a8" }

  #     before do
  #       board_tester.clear_board
  #       board_tester.add_piece('d', 1, white_king)
  #       board_tester.add_piece('e', 4, white_rook)
  #       board_tester.add_piece('a', 7, white_rook)

  #       board_tester.add_piece('d', 8, black_king)
  #       board_tester.add_piece('d', 7, black_pawn)
  #       allow(chess_game_tester).to receive(:take_input_and_clean).and_return(move, "quit")
  #     end

  #     it 'checks black' do
  #       expect(chess_game_tester).to receive(:check?).and_return(true)
  #       chess_game_tester.game_loop
  #     end
  #   end
    
  #   context 'When white player checkmates black' do

  #     let(:board_tester) { ChessBoard.new }
      
  #     let(:white_king)   { King.new("white") }
  #     let(:white_queen)  { Queen.new("white") }
  #     let(:white_rook)   { Rook.new("white") }

  #     let(:black_king)   { King.new("black") }
  #     let(:black_pawn)   { Pawn.new("black") }

  #     let(:move) { "a7 a8" }

  #     before do
  #       board_tester.clear_board
  #       board_tester.add_piece('d', 1, white_king)
  #       board_tester.add_piece('c', 5, white_queen)
  #       board_tester.add_piece('e', 4, white_rook)
  #       board_tester.add_piece('a', 7, white_rook)

  #       board_tester.add_piece('d', 8, black_king)
  #       board_tester.add_piece('d', 7, black_pawn)
  #       allow(chess_game_tester).to receive(:take_input_and_clean).and_return(move, "quit")
  #     end

  #     it 'ends the game' do
  #       expect(chess_game_tester.game_loop).to eq("checkmate")
  #     end
  #   end
  # end

  # describe '#game_ends' do
  # end

end