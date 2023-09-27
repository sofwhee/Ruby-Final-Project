require './lib/ChessBoard.rb'
require './lib/ChessReferee.rb'

describe ChessBoard do
  let(:board_tester) { ChessBoard.new }
  let(:referee_tester) { ChessReferee.new }
  
  describe '#initialize' do
  end

  # describe '#build_board' do
  #   it 'returns correct keys' do
  #     correct_keys = ["a", "b", "c", "d", "e", "f", "g", "h"]
  #     expect(board_tester.board.keys).to eq(correct_keys)
  #   end

  #   it 'returns eight keys' do
  #     expect(board_tester.board.keys.length).to eq(8)
  #   end

  #   it 'has an object in each key that responds to .data' do
  #     for key, value in board_tester.board
  #       for val in value
  #         expect(val.data).to be_truthy
  #       end
  #     end
  #   end
  # end

  # describe '#board_to_sq' do
  #   it 'returns all squares in board' do
  #     expect(board_tester.board_to_sq.size).to eq((8*8))
  #   end
  # end

  # describe '#squares_uni_str' do
  #   context 'when board is empty' do
  #     it 'returns 8x8 length str' do
  #       expect(board_tester.squares_uni_str.length).to eq((8*8))
  #     end

  #     it 'returns only underscores' do
  #       result = board_tester.squares_uni_str.chars
  #       result = result.all? { |char| char == "_" }
  #       expect(result).to be true
  #     end
  #   end

  #   context 'when board has a knight piece on the board at ["a", "1"]' do
  #     it 'returns the piece unicode in the first position' do
  #       knight = Knight.new("black", "8")
  #       board_tester.add_piece("a", 8, knight)
  #       result = board_tester.squares_uni_str.chars
  #       p result
  #       expect(result.first).to eq(knight.to_uni)
  #     end
  #   end
  # end

  # describe '#sq_unis_to_board' do
  #   context 'when board is empty' do
  #     it 'returns \\n every 8 chars' do
  #       board_str = board_tester.sq_unis_to_board
  #       expect(board_str[19]).to eq("\n")
  #     end
  #   end
  # end

  # describe '#to_s' do
  #   let(:empty_board) { 
  #     board_str = <<~BOARD
  #        a b c d e f g h
  #        _ _ _ _ _ _ _ _
  #     8 |_|_|_|_|_|_|_|_|
  #     7 |_|_|_|_|_|_|_|_|
  #     6 |_|_|_|_|_|_|_|_|
  #     5 |_|_|_|_|_|_|_|_|
  #     4 |_|_|_|_|_|_|_|_|
  #     3 |_|_|_|_|_|_|_|_|
  #     2 |_|_|_|_|_|_|_|_|
  #     1 |_|_|_|_|_|_|_|_|
  #     BOARD
  #   }

  #   context 'when board is empty' do
  #     it 'returns board' do
  #       expect(board_tester.to_s).to eq(empty_board)
  #     end
  #   end

  #   let(:knight) { Knight.new("black", "1") }

  #   context 'when board has black knight at a1' do
  #     it 'returns board with black knight at a1' do
  #       board_tester.add_piece("a", 1, knight)
  #       puts board_tester.to_s
  #       one_location = board_tester.to_s.index("1")
  #       expect(board_tester.to_s[one_location + 3]).to eq(knight.to_uni)
  #     end
  #   end

  #   let(:white_knight) { Knight.new("white", "1") }

  #   context 'when board has white knight at b1' do
  #     it 'returns board with white knight at b1' do
  #       board_tester.add_piece("b", 1, white_knight)
  #       puts board_tester.to_s
  #       one_location = board_tester.to_s.index("1")
  #       expect(board_tester.to_s[one_location + 5]).to eq(white_knight.to_uni)
  #     end
  #   end
  # end

  describe '#clear_board' do
    context 'when called' do
      it 'empties pieces_on_board' do
        board_tester.add_piece('a', 2, Knight.new("black", "left knight"))
        expect { board_tester.clear_board }.to change { board_tester.pieces_on_board }.to eq([])
      end
    end
  end

  # describe '#get_square' do
  #   context 'when given coordinates that point to a valid square in hash' do
  #     it 'returns the square' do
  #       square_returned = board_tester.get_square('a', 8)
  #       expect(square_returned.data).to eq(['a', '8'])
  #     end
  #   end
  # end

  # describe '#get_piece_square' do
  #   let(:piece_test) { Pieces.new }

  #   let(:test_king)     { piece_test.create("black", "king") }
  #   let(:test_king_wh)  { piece_test.create("white", "king") }
  #   let(:left_kn)   { piece_test.create("black", "knight", "left") }
  #   let(:right_kn)  { piece_test.create("black", "knight", "right") }

  #   before do
  #     board_tester.add_piece('e', 8, test_king)
  #     board_tester.add_piece('e', 1, test_king_wh)
  #     board_tester.add_piece('e', 4, left_kn)
  #     board_tester.add_piece('e', 6, right_kn)
  #   end

  #   context 'when given the name of a piece on the board' do
  #     it 'returns a square' do
  #       expect(board_tester.get_piece_square("black", "king").instance_of?(Square)).to be true
  #     end

  #     it 'with ["e", 8] as its data' do
  #       expect(board_tester.get_piece_square("black", "king").data).to eq(["e", "8"])
  #     end

  #     it 'returns a square' do
  #       expect(board_tester.get_piece_square("black", "knight", "left").instance_of?(Square)).to be true
  #     end

  #     it 'with ["e", 4] as its data' do
  #       expect(board_tester.get_piece_square("black", "knight", "left").data).to eq(["e", "4"])
  #     end
    
  #     it 'returns a square' do
  #       expect(board_tester.get_piece_square("black", "knight", "right").instance_of?(Square)).to be true
  #     end

  #     it 'with ["e", 6] as its data' do
  #       expect(board_tester.get_piece_square("black", "knight", "right").data).to eq(["e", "6"])
  #     end
  #   end

  #   context 'when player is 2' do
  #     it 'returns a square with ["e", 1] as its data' do
  #       expect(board_tester.get_piece_square("white", "king").data).to eq(["e", "1"])
  #     end
  #   end
  # end

  # describe '#get_piece_squares' do

  #   let(:piece_test) { Pieces.new }

  #   let(:left_kn)   { piece_test.create("black", "knight", "left") }
  #   let(:right_kn)  { piece_test.create("black", "knight", "right") }
  #   let(:a7_pawn)   { piece_test.create("black", "pawn", "a7") }

  #   let(:piece_list)  { [left_kn, right_kn, a7_pawn] }

  #   before do
  #     board_tester.add_piece('e', 4, left_kn)
  #     board_tester.add_piece('e', 6, right_kn)
  #     board_tester.add_piece('a', 4, a7_pawn)
  #   end

  #   context 'when given a list of pieces' do
  #     it 'returns squares which have those pieces' do
  #       # list = board_tester.get_piece_squares(piece_list)
  #       # list = list.map { |sq| sq.piece }
  #       # expect(list).to include(left_kn, right_kn, a7_pawn)

  #       piece_list_coord = []

  #       for squ in board_tester.get_piece_squares(piece_list)
  #         piece_list_coord << squ.data
  #       end
       
  #       expect(piece_list_coord).to include(['e', '4'], ['e', '6'], ['a', '4'])
  #     end
  #   end
  # end

  # describe '#array_to_squares' do
  #   context 'when given [[2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]' do
  #     input_array = [["b", 2], ["c", 3], ["d", 4], ["e", 5], ["f", 6], ["g", 7]]
      
  #     it 'makes an array of length 6' do
  #       expect(board_tester.array_to_squares(input_array).size).to eq(6)
  #     end

  #     it 'makes an array of squares' do
  #       sq_array = board_tester.array_to_squares(input_array)
  #       all_squares = sq_array.all? { |sq| sq.is_a?(Square) }
  #       expect(all_squares).to be true
  #     end
      
  #     it 'maps a Square object with each coord as its .data' do
  #       sq_array = board_tester.array_to_squares(input_array)
  #       sq_array.map! { |sq| sq.data }
  #       sq_array.map! { |data| data = [data[0], data[1].to_i] }
  #       expect(sq_array).to eq(input_array)
  #     end
  #   end
  # end
  
  # describe '#path_to_squares' do
  #   context 'when start square is a1 and end square is a8' do
  #     it 'returns squares: a2, a3... a7' do
  #       start, last = ["a", 1], ["a", 8]
  #       start, last = board_tester.convert_from_chess(start), board_tester.convert_from_chess(last)
  #       path = referee_tester.movement_path(start, last)
  #       result = [["a", "2"], ["a", "3"], ["a", "4"], ["a", "5"], ["a", "6"], ["a", "7"]]
        
  #       squares_data_list = board_tester.path_to_squares(path)
  #       squares_data_list.map! { |sq| sq.data }
  #       expect(squares_data_list).to eq(result)
  #     end
  #   end

  #   context 'when start square is b8 and end square is b1' do
  #     it 'returns squares: b7, b6... b2' do
  #       start, last = ["b", "8"], ["b", "1"]
  #       start, last = board_tester.convert_from_chess(start), board_tester.convert_from_chess(last)
  #       path = referee_tester.movement_path(start, last)
  #       result = [["b", "7"], ["b", "6"], ["b", "5"], ["b", "4"], ["b", "3"], ["b", "2"]]
        
  #       squares_data_list = board_tester.path_to_squares(path)
  #       squares_data_list.map! { |sq| sq.data }
  #       expect(squares_data_list).to eq(result)
  #     end
  #   end

  #   context 'when start square is a1 and end square is h8' do
  #     it 'returns squares: b2, c3... g7' do
  #       start, last = ["a", "1"], ["h", "8"]
  #       start, last = board_tester.convert_from_chess(start), board_tester.convert_from_chess(last)
  #       path = referee_tester.movement_path(start, last)
  #       result = [["b", "2"], ["c", "3"], ["d", "4"], ["e", "5"], ["f", "6"], ["g", "7"]]
        
  #       squares_data_list = board_tester.path_to_squares(path)
  #       squares_data_list.map! { |sq| sq.data }
  #       expect(squares_data_list).to eq(result)
  #     end
  #   end

  #   context 'when start square is a1 and end square is a2' do
  #     it 'returns nothing' do
  #       start, last = ["a", "1"], ["a", "2"]
  #       start, last = board_tester.convert_from_chess(start), board_tester.convert_from_chess(last)
  #       path = referee_tester.movement_path(start, last)
  #       result = []
  
  #       squares_data_list = board_tester.path_to_squares(path)
  #       squares_data_list.map! { |sq| sq.data }
  #       expect(squares_data_list).to eq(result)
  #     end
  #   end
  # end

  # describe '#side_pieces' do

  #   let(:piece_test) { Pieces.new }

  #   let(:left_kn)   { piece_test.create("black", "knight", "left") }
  #   let(:right_kn)  { piece_test.create("black", "knight", "right") }
  #   let(:a7_pawn)   { piece_test.create("black", "pawn", "a7") }

  #   let(:bl_piece_list)  { [left_kn, right_kn, a7_pawn] }

  #   let(:w_left_kn)   { piece_test.create("white", "knight", "left") }
  #   let(:w_right_kn)  { piece_test.create("white", "knight", "right") }
  #   let(:a1_pawn)   { piece_test.create("white", "pawn", "a1") }

  #   let(:w_piece_list)  { [w_left_kn, w_right_kn, a1_pawn] }

  #   before do
  #     board_tester.add_piece('e', 4, left_kn)
  #     board_tester.add_piece('e', 6, right_kn)
  #     board_tester.add_piece('a', 4, a7_pawn)

  #     board_tester.add_piece('b', 7, w_left_kn)
  #     board_tester.add_piece('d', 5, w_right_kn)
  #     board_tester.add_piece('a', 1, a1_pawn)
  #   end

  #   context 'when given "black" side' do
  #     it 'returns all black pieces on the board' do
  #       bl_pieces = board_tester.side_pieces("black")
  #       expect(bl_pieces).to include(left_kn, right_kn, a7_pawn)
  #     end

  #     it 'does not return any other pieces' do
  #       bl_pieces = board_tester.side_pieces("black")
  #       expect(bl_pieces.size).to eq(3)
  #     end
  #   end

  #   context 'when given "white" side' do
  #     it 'returns all white pieces on the board' do
  #       w_pieces = board_tester.side_pieces("white")
  #       expect(w_pieces).to include(w_left_kn, w_right_kn, a1_pawn)
  #     end

  #     it 'does not return any other pieces' do
  #       w_pieces = board_tester.side_pieces("white")
  #       expect(w_pieces.size).to eq(3)
  #     end
  #   end
  # end

  # describe '#add_piece' do
  #   let(:column) { "a" }
  #   let(:row)    { 8 }
  #   let(:piece)  { double(Pieces) }

  #   it 'changes the square specified' do
  #     expect { board_tester.add_piece(column, row, piece) }
  #     .to change { board_tester.board[column][row - 1].piece }
  #   end

  #   it 'adds piece to piece list' do
  #     expect { board_tester.add_piece(column, row, piece) }
  #     .to change { board_tester.pieces_on_board.length }.by(1)
  #   end
  # end

  # describe '#move_piece' do
  #   context 'when moving a piece from one square to another' do
  #     let(:knight)          { Knight.new }
  #     let(:enemy_knight)    { Knight.new("white") }

  #     let(:empty_square)    { Square.new }

  #     let(:knight_square)   { Square.new }
  #     let(:fr_kn_square)    { Square.new }
  #     let(:en_kn_square)    { Square.new }

  #     before do
  #       allow(board_tester).to receive(:remove_piece)
  #       knight_square.piece = knight
  #       fr_kn_square.piece  = knight
  #       en_kn_square.piece  = enemy_knight
  #     end

  #     context 'if it is an empty square' do
        
  #       it 'removes the piece from the first square, and places it into the new square' do
  #         expect { board_tester.move_piece(knight_square, empty_square) }
  #         .to change { knight_square.piece }
  #         .from(knight).to(nil)
  #         .and change { empty_square.piece }
  #         .from(nil).to(knight)
  #       end

  #       it 'doesnt call remove_piece' do
  #         expect(board_tester).not_to receive(:remove_piece)
  #         board_tester.move_piece(knight_square, empty_square)
  #       end
  #     end

  #     context 'if square has an enemy piece' do

  #       it 'replaces it with knight' do
  #         expect { board_tester.move_piece(knight_square, en_kn_square) }
  #         .to change { en_kn_square.piece }
  #         .from(enemy_knight).to(knight)
  #       end

  #       it 'calls remove_piece' do
  #         expect(board_tester).to receive(:remove_piece)
  #         board_tester.move_piece(knight_square, en_kn_square)
  #       end
  #     end
  #   end
  # end

  # describe '#remove_piece' do
  #   let(:column) { "a" }
  #   let(:row)    { 8 }
  #   let(:piece_name) { ["black", "knight", "left"] }
  #   let(:piece)  { instance_double(Knight, side: "black", name: "knight", identifier: "left") }

  #   it 'changes the square specified' do
  #     board_tester.add_piece(column, row, piece)
  #     expect { board_tester.remove_piece(piece_name[0], piece_name[1], piece_name[2]) }
  #     .to change { board_tester.board[column][row - 1].piece }.to(nil)
  #   end

  #   it 'removes piece from piece list' do
  #     board_tester.add_piece(column, row, piece)
  #     expect { board_tester.remove_piece(piece_name[0], piece_name[1], piece_name[2]) }
  #     .to change { board_tester.pieces_on_board.length }.by(-1)
  #   end
  # end

end