require './lib/Board.rb'
require './lib/Pieces.rb'

describe Board do
  
  subject(:board_tester) { Board.new() }

  # describe '#move_path_tree' do
  #   context 'when given a square and a knights movement' do
  #     let(:tester_square) { Square.new([1, 1]) }
  #     let(:tester_knight) { Knight.new() }
  #     let(:knight_moves)  { tester_knight.possible_moves }
  #     let(:correct_moves) { [[2, 3], [3, 2]] }

  #     it 'loops 8 times' do
  #       expect(board_tester).to receive(:legal_move?).exactly(8).times
  #       board_tester.move_path_tree(tester_square, knight_moves)
  #     end

  #     it 'assigns two children' do
  #       expect{ board_tester.move_path_tree(tester_square, knight_moves) }
  #       .to change { tester_square.children.length }.by(2)
  #     end

  #     it 'assigns correct children' do
  #       board_tester.move_path_tree(tester_square, knight_moves)
  #       tester_children_list = tester_square.children.map { |child| child.data }
  #       expect(tester_children_list - correct_moves).to eq([])
  #     end
  #   end

  #   context 'when given the middle square' do
  #     let(:tester_square) { Square.new([4, 4]) }
  #     let(:tester_knight) { Knight.new() }
  #     let(:knight_moves)  { tester_knight.possible_moves }
  #     let(:correct_moves) { [[2, 3], [3, 2], [2, 5], [3, 6], [5, 6], [6, 5], [5, 2], [6, 3]] }

  #     it 'loops 8 times' do
  #       expect(board_tester).to receive(:legal_move?).exactly(8).times
  #       board_tester.move_path_tree(tester_square, knight_moves)
  #     end

  #     it 'assigns eight children' do
  #       expect{ board_tester.move_path_tree(tester_square, knight_moves) }
  #       .to change { tester_square.children.length }.by(8)
  #     end

  #     it 'assigns correct children' do
  #       board_tester.move_path_tree(tester_square, knight_moves)
  #       tester_children_list = tester_square.children.map { |child| child.data }
  #       expect(tester_children_list - correct_moves).to eq([])
  #     end
  #   end

  #   context 'when given a square and a pawns movement' do
  #     let(:tester_square) { Square.new([1, 1]) }
  #     let(:tester_pawn) { Pawn.new() }
  #     let(:pawn_moves)  { tester_pawn.possible_moves }
  #     let(:correct_moves) { [[1, 2]] }

  #     it 'loops 1 times' do
  #       expect(board_tester).to receive(:legal_move?).once
  #       board_tester.move_path_tree(tester_square, pawn_moves)
  #     end

  #     it 'assigns one child' do
  #       expect{ board_tester.move_path_tree(tester_square, pawn_moves) }
  #       .to change { tester_square.children.length }.by(1)
  #     end

  #     it 'assigns correct children' do
  #       board_tester.move_path_tree(tester_square, pawn_moves)
  #       tester_children_list = tester_square.children.map { |child| child.data }
  #       expect(tester_children_list - correct_moves).to eq([])
  #     end
  #   end

  #   context 'when given the middle square' do
  #     let(:tester_square) { Square.new([4, 4]) }
  #     let(:tester_pawn) { Pawn.new() }
  #     let(:pawn_moves)  { tester_pawn.possible_moves }
  #     let(:correct_moves) { [[4, 5]] }

  #     it 'loops 1 times' do
  #       expect(board_tester).to receive(:legal_move?).once
  #       board_tester.move_path_tree(tester_square, pawn_moves)
  #     end

  #     it 'assigns 1 child' do
  #       expect{ board_tester.move_path_tree(tester_square, pawn_moves) }
  #       .to change { tester_square.children.length }.by(1)
  #     end

  #     it 'assigns correct children' do
  #       board_tester.move_path_tree(tester_square, pawn_moves)
  #       tester_children_list = tester_square.children.map { |child| child.data }
  #       expect(tester_children_list - correct_moves).to eq([])
  #     end
  #   end
  # end

  # describe '#movement_path' do
  #   context 'when given a Knight' do
  #     let(:knight) { Knight.new() }
  #     context 'moving from [1, 1] to [1, 2]' do
  #       it 'returns [[1, 1], [1, 2]]' do
  #         path = board_tester.movement_path(knight.possible_moves, [1, 1], [2, 3])
  #         expect(path).to eq([[1, 1], [2, 3]])
  #       end
  #     end

  #     context 'moving from [1, 1] to [2, 4]' do
  #       it 'returns three moves' do
  #         path = board_tester.movement_path(knight.possible_moves, [1, 1], [3, 5])
  #         expect(path.length).to eq(3)
  #       end
  #     end
  #   end

  #   context 'when given a black Pawn' do
  #     let(:pawn) { Pawn.new() }
  #     context 'moving from [1, 1] to [1, 1]' do
  #       it 'returns [[1, 1], [1, 1]]' do
  #         path = board_tester.movement_path(pawn.possible_moves, [1, 1], [1, 2])
  #         expect(path).to eq([[1, 1], [1, 2]])
  #       end
  #     end

  #     context 'moving from [4, 1] to [4, 4]' do
  #       it 'returns [[4, 1], [4, 1]... [4, 4]]' do
  #         path = board_tester.movement_path(pawn.possible_moves, [4, 1], [4, 4])
  #         expect(path).to eq([[4, 1], [4, 2], [4, 3], [4, 4]])
  #       end
  #     end
  #   end

  #   context 'when given a white Pawn' do
  #     let(:pawn) { Pawn.new("white") }
  #     context 'moving from [4, 4] to [4, 3]' do
  #       it 'returns [[4, 4] to [4, 3]]' do
  #         path = board_tester.movement_path(pawn.possible_moves, [4, 4], [4, 3])
  #         expect(path).to eq([[4, 4], [4, 3]])
  #       end
  #     end

  #     context 'moving from [4, 4] to [4, 1]' do
  #       it 'returns [[4, 1], [4, 1]... [4, 4]]' do
  #         path = board_tester.movement_path(pawn.possible_moves, [4, 4], [4, 1])
  #         expect(path).to eq([[4, 4], [4, 3], [4, 2], [4, 1]])
  #       end
  #     end
  #   end

  #   context 'when given a Rook with 8x8 dimensions' do
  #     let(:rook) { Rook.new() }
  #     context 'moving from [1, 1] to [1, 8]' do
  #       it 'returns [[1, 1] to [1, 8]]' do
  #         path = board_tester.movement_path(rook.possible_moves, [1, 1], [1, 8])
  #         expect(path).to eq([[1, 1], [1, 8]])
  #       end
  #     end

  #     context 'moving from [1, 8] to [1, 1]' do
  #       it 'returns [[1, 8] [1, 1]]' do
  #         path = board_tester.movement_path(rook.possible_moves, [1, 8], [1, 1])
  #         expect(path).to eq([[1, 8], [1, 1]])
  #       end
  #     end

  #     context 'moving from [1, 1] to [8, 8]' do
  #       it 'returns three squares' do
  #         path = board_tester.movement_path(rook.possible_moves, [1, 1], [8, 8])
  #         expect(path.length).to eq(3)
  #       end
  #     end
  #   end

  #   context 'when given a Bishop with 8x8 dimensions' do
  #     let(:bishop) { Bishop.new() }
  #     context 'moving from [1, 1] to [4, 4]' do
  #       it 'returns [[1, 1], [4, 4]]' do
  #         path = board_tester.movement_path(bishop.possible_moves, [1, 1], [4, 4])
  #         expect(path).to eq([[1, 1], [4, 4]])
  #       end
  #     end

  #     context 'moving from [4, 4] to [1, 1]' do
  #       it 'returns [[4, 4], [1, 1]]' do
  #         path = board_tester.movement_path(bishop.possible_moves, [4, 4], [1, 1])
  #         expect(path).to eq([[4, 4], [1, 1]])
  #       end
  #     end

  #     context 'moving from [1, 1] to [8, 8]' do
  #       it 'returns two squares' do
  #         path = board_tester.movement_path(bishop.possible_moves, [1, 1], [8, 8])
  #         expect(path.length).to eq(2)
  #       end
  #     end
  #   end

  #   context 'when given a King' do
  #     let(:king) { King.new() }
  #     context 'moving from [1, 1] to [2, 2]' do
  #       it 'returns [[1, 1] to [2, 2]]' do
  #         path = board_tester.movement_path(king.possible_moves, [1, 1], [2, 2])
  #         expect(path).to eq([[1, 1], [2, 2]])
  #       end
  #     end

  #     context 'moving from [1, 1] to [4, 4]' do
  #       it 'returns four squares' do
  #         path = board_tester.movement_path(king.possible_moves, [1, 1], [4, 4])
  #         expect(path.length).to eq(4)
  #       end
  #     end

  #     context 'moving from [4, 4] to [1, 1]' do
  #       it 'returns four squares' do
  #         path = board_tester.movement_path(king.possible_moves, [4, 4], [1, 1])
  #         expect(path.length).to eq(4)
  #       end
  #     end
  #   end

  #   context 'when given a Queen with 8x8 dimensions' do
  #     let(:queen) { Queen.new() }
  #     context 'moving from [1, 1] to [1, 1]' do
  #       it 'returns [[1, 1] to [1, 1]]' do
  #         path = board_tester.movement_path(queen.possible_moves, [1, 1], [2, 2])
  #         expect(path).to eq([[1, 1], [2, 2]])
  #       end
  #     end

  #     context 'moving from [1, 1] to [4, 4]' do
  #       it 'returns two squares' do
  #         path = board_tester.movement_path(queen.possible_moves, [1, 1], [4, 4])
  #         expect(path.length).to eq(2)
  #       end
  #     end

  #     context 'moving from [1, 1] to [1, 4]' do
  #       it 'returns two squares' do
  #         path = board_tester.movement_path(queen.possible_moves, [1, 1], [1, 4])
  #         expect(path.length).to eq(2)
  #       end
  #     end

  #     context 'moving from [1, 1] to [4, 1]' do
  #       it 'returns two squares' do
  #         path = board_tester.movement_path(queen.possible_moves, [1, 1], [4, 1])
  #         expect(path.length).to eq(2)
  #       end
  #     end

  #     context 'moving from [4, 4] to [1, 1]' do
  #       it 'returns two squares' do
  #         path = board_tester.movement_path(queen.possible_moves, [4, 4], [1, 1])
  #         expect(path.length).to eq(2)
  #       end
  #     end
  #   end
  # end

  # describe '#return_lineage' do

  #   let(:square_parent) { Square.new("square_parent") }
  #   let(:square_child1) { Square.new("square_child1", square_parent) }
  #   let(:square_child2) { Square.new("square_child2", square_child1) }

  #   context 'when given a Square that is a child of two Squares' do
  #     it 'returns an array of that child and all of its parents data' do
  #       expect(board_tester.return_lineage(square_child2)).to \
  #       eq([square_parent.data, square_child1.data, square_child2.data])
  #     end
  #   end
  # end

end