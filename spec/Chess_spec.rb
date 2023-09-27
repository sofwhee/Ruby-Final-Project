require 'Chess.rb'

describe Chess do

  subject(:chess_tester) { Chess.new }

  describe '#switch_player' do
    context 'player is white' do
      it 'changes player to black' do
        expect { chess_game_tester.switch_player }.to \
        change { chess_game_tester.player }.to eq("black")
      end
    end

    context 'player is black' do
      it 'changes player to white' do
        chess_game_tester.switch_player
        expect { chess_game_tester.switch_player }.to \
        change { chess_game_tester.player }.to eq("white")
      end
    end
  end

  describe '#convert_from_chess' do
    context 'when given chess square [a, 8]' do
      it 'returns [1, 1]' do
        expect(chess_tester.convert_from_chess(['a', '8'])).to eq([1, 1])
      end
    end
  end

  describe '#convert_to_chess' do
    context 'when given coordinates [1, 1]' do
      it 'returns [a, 8]' do
        expect(chess_tester.convert_to_chess([1, 1])).to eq(['a', '8'])
      end
    end
  end

  describe '#move' do
    context 'when given [3, 5], [1, 1]' do
      it 'returns [4, 6]' do
        expect(chess_tester.move([3, 5], [1, 1])).to eq([4, 6])
      end
    end
  end
  
end