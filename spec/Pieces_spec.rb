require './lib/Pieces.rb'

describe Pieces do

  subject(:pieces_tester) { Pieces.new() }

  describe '#initialize' do
  end
  
  describe '#generate_moves' do
    context 'when given a rook with 8x8 dimensions' do
      let(:rook) { Rook.new("black") }

      it 'returns dim*dim / 2 size list' do
        p rook.moves
        expect(rook.moves.length).to eq((8*8) / 2)
      end
    end

    context 'when given a Queen with 8x8 dimensions' do
      let(:queen) { Queen.new("black") }

      it 'returns dim*dim size list' do
        expect(queen.moves.length).to eq(8*8)
      end
    end
  end
  
  # describe '#can_move?' do
  #   context 'when using a knight' do
  #     let(:knight) { Knight.new() }
  #     let(:position) { ['a', '8']}

  #     context 'from [a, 8] to [b, 6]' do
  #       it 'returns true' do
  #         expect(knight.can_move?(position, ['b', '6'])).to be true
  #       end
  #     end

  #     context 'from [a, 8] to [b, 5]' do
  #       it 'returns nil' do
  #         expect(knight.can_move?(position, ['b', '5'])).to be false
  #       end
  #     end

  #     context 'from [b, 8] to [g, 2]' do
  #       it 'returns nil' do
  #         expect(knight.can_move?(['b', '8'], ['g', '2'])).to be false
  #       end
  #     end
  #   end

  #   context 'when using a black pawn' do
  #     let(:pawn) { Pawn.new() }
  #     let(:position) { ['a', '8']}

  #     context 'from [a, 8] to [a, 7]' do
  #       it 'returns true' do
  #         expect(pawn.can_move?(position, ['a', '7'])).to be true
  #       end
  #     end

  #     context 'from [a, 7] to [a, 8]' do
  #       it 'returns nil' do
  #         expect(pawn.can_move?(['a', '7'], position)).to be false
  #       end
  #     end
  #   end

  #   context 'when using a queen' do
  #     let(:queen) { Queen.new() }
  #     let(:position) { ['a', '8']}

  #     context 'from [a, 8] to [h, 1]' do
  #       it 'returns true' do
  #         expect(queen.can_move?(position, ['h', '1'])).to be true
  #       end
  #     end

  #     context 'from [a, 8] to [g, 1]' do
  #       it 'returns nil' do
  #         expect(queen.can_move?(position, ['g', '1'])).to be false
  #       end
  #     end
  #   end
  # end

  # describe '#can_attack?' do
  #   context 'when using a knight' do
  #     let(:knight) { Knight.new() }
  #     let(:position) { ['a', '8']}

  #     context 'from [a, 8] to [b, 6]' do
  #       it 'returns true' do
  #         expect(knight.can_move?(position, ['b', '6'])).to be true
  #       end
  #     end
  #   end

  #   context 'when using a black pawn' do
  #     let(:pawn) { Pawn.new() }
  #     let(:w_pawn) { Pawn.new("white") }
  #     let(:position) { ['a', '7'] }

  #     context 'from [a, 7] to [b, 6]' do
  #       it 'returns true' do
  #         expect(pawn.can_attack?(position, ['b', '6'])).to be true
  #       end
  #     end

  #     context 'from [a, 7] to [b, 6]' do
  #       it 'returns true' do
  #         expect(w_pawn.can_attack?(position, ['b', '6'])).to be false
  #       end
  #     end

  #     context 'from [b, 6] to [a, 7]' do
  #       it 'returns true' do
  #         expect(pawn.can_attack?(['b', '6'], position)).to be false
  #       end
  #     end

  #     context 'from [b, 6] to [a, 7]' do
  #       it 'returns true' do
  #         expect(w_pawn.can_attack?(['b', '6'], position)).to be true
  #       end
  #     end
  #   end

  #   context 'when using a queen' do
  #     let(:queen) { Queen.new() }
  #     let(:position) { ['a', '8']}

  #     context 'from [a, 8] to [h, 1]' do
  #       it 'returns true' do
  #         expect(queen.can_move?(position, ['h', '1'])).to be true
  #       end
  #     end

  #     context 'from [a, 8] to [g, 1]' do
  #       it 'returns nil' do
  #         expect(queen.can_move?(position, ['g', '1'])).to be false
  #       end
  #     end
  #   end
  # end

  describe '#create' do
    context 'when given the colour black, the name knight, and an identifer' do
      let(:piece) { pieces_tester.create("left", "black", "knight") }

      it 'creates a Knight object' do
        expect(piece.instance_of?(Knight)).to be true
      end
      
      it 'with the correct name' do
        expect(piece.name).to eq("knight")
      end

      it 'with the correct identifier' do
        expect(piece.identifier).to eq("left")
      end
    end

    context 'when given the colour black, the name pawn, and the side b' do
      let(:piece) { pieces_tester.create("b", "black", "pawn") }

      it 'creates a Pawn object' do
        expect(piece.instance_of?(Pawn)).to be true
      end
      
      it 'with the correct name' do
        expect(piece.name).to eq("pawn")
      end

      it 'with the correct identifier' do
        expect(piece.identifier).to eq("b")
      end
    end
  end
  
end