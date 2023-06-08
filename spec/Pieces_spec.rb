require './lib/Pieces.rb'

describe Pieces do

  describe '#initialize' do
    context 'after creating three pieces' do
      it 'puts them into class attribute' do
        Pieces.clear_all_pieces
        knight = Knight.new
        pawn = Pawn.new
        queen = Queen.new
        expect(Pieces.all_pieces.length).to eq(3)
      end
    end
  end
  
  describe '#generate_moves' do
    context 'when given a knights moves' do
      let(:knight) { Knight.new() }
      let(:moves) { [[1, 2], [2, 1], [1, -2], [2, -1], [-1, 2], [-2, 1], [-1, -2], [-2, -1]] }
      
      it 'returns all eight possible movements' do
        knight_moves = knight.generate_moves
        knight_moves = knight_moves.select { |kn_move| moves.include?(kn_move) }
        expect(knight_moves.length).to eq(moves.length)
      end
    end

    context 'when given a black pawn' do
      let(:pawn) { Pawn.new() }
      
      it 'returns [[0, 1]]' do
        expect(pawn.possible_moves).to eq([[0, 1]])
      end
    end

    context 'when given a white pawn' do
      let(:pawn) { Pawn.new("white") }
      
      it 'returns [[0, -1]]' do
        expect(pawn.possible_moves).to eq([[0, -1]])
      end
    end

    context 'when given a rook with 8x8 dimensions' do
      let(:rook) { Rook.new([8, 8]) }

      it 'returns dim*dim / 2 size list' do
        expect(rook.possible_moves.length).to eq((8*8) / 2)
      end
    end

    context 'when given a Queen with 8x8 dimensions' do
      let(:queen) { Queen.new([8, 8]) }

      it 'returns dim*dim size list' do
        expect(queen.possible_moves.length).to eq(8*8)
      end
    end
  end

  describe '#convert_from_chess' do
  end

  describe '#can_move?' do
    context 'when using a knight' do
      let(:knight) { Knight.new() }

      context 'from [a, 8] to [b, 6]' do
        it 'returns true' do
          expect(knight.can_move?(['a', 8], ['b', 6])).to be true
        end
      end

      context 'from [a, 8] to [b, 5]' do
        it 'returns nil' do
          expect(knight.can_move?(['a', 8], ['b', 5])).to be nil
        end
      end
    end

    context 'when using a black pawn' do
      let(:pawn) { Pawn.new() }

      context 'from [a, 8] to [a, 7]' do
        it 'returns true' do
          expect(pawn.can_move?(['a', 8], ['a', 7])).to be true
        end
      end

      context 'from [a, 7] to [a, 8]' do
        it 'returns nil' do
          expect(pawn.can_move?(['a', 7], ['a', 8])).to be nil
        end
      end
    end

    context 'when using a queen' do
      let(:queen) { Queen.new() }

      context 'from [a, 8] to [h, 1]' do
        it 'returns true' do
          expect(queen.can_move?(['a', 8], ['h', 1])).to be true
        end
      end

      context 'from [a, 8] to [g, 1]' do
        it 'returns nil' do
          expect(queen.can_move?(['a', 8], ['g', 1])).to be nil
        end
      end
    end
  end
end