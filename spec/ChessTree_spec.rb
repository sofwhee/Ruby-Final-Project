require './lib/ChessTree.rb'

describe ChessTree do

  subject(:tree_tester) { ChessTree.new }
  
  describe '#how_many_moves' do
    context 'how_many_moves' do
      it 're' do
      end
    end
  end

  describe '#move_path_tree' do
    context 'when the root square is [a, 8] and is given a black pawns moves' do
      
      let(:root_square) { ['a', '8'] }
      let(:black_pawn)  { Pawn.new }
      let(:moves_array) { black_pawn.possible_moves }

      it 'the root squares children will equal [[a, 7]]' do
        expect { tree_tester.move_path_tree(root_square, moves_array) }.to change {}.to eq([['a', '7']])
      end
    end
  end

end