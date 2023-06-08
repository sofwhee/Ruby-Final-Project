require './lib/Chess.rb'

describe Chess do
  let(:piece_tester) { double(Pieces) }
  let(:chess_tester) { Chess.new }
  
  describe '#initialize' do
  end

  describe '#build_board' do
    it 'returns correct keys' do
      correct_keys = ["a", "b", "c", "d", "e", "f", "g", "h"]
      expect(chess_tester.board.keys).to eq(correct_keys)
    end

    it 'returns eight nested keys' do
      expect(chess_tester.board["a"].keys.length).to eq(8)
    end

    it 'has an object in each key that responds to .data' do
      for key, value in chess_tester.board
        for n_key, n_value in value
          expect(n_value.data).to be_truthy
        end
      end
    end
  end

  # describe '#intro_str' do
  # end

  # describe 'set_pieces' do
  # end

  describe '#convert_from_chess' do
    context 'when given chess square [a, 8]' do
      it 'returns [1, 1]' do
        expect(chess_tester.convert_from_chess(['a', 8])).to eq([1, 1])
      end
    end
  end

  describe '#convert_to_chess' do
    context 'when given coordinates [1, 1]' do
      it 'returns [a, 8]' do
        expect(chess_tester.convert_to_chess([1, 1])).to eq(['a', 8])
      end
    end
  end

  # describe '#move' do
  # end

  # describe '#piece_can_move?' do
  #   context 'when given a knights moves' do
  #     context 'when given a valid move' do
  #       it 'returns true' do
  #       end
  #     end
  #   end
  # end

  describe '#within_board?' do
    before do
      allow(chess_tester).to receive(:puts)
    end
    
    context 'when given coordinates in the chess board' do
      it 'returns true' do
        expect(chess_tester.within_board?(['a', 8])).to be true
      end
    end

    context 'when given coordinates outside the chess board' do
      it 'returns nil' do
        expect(chess_tester.within_board?(['a', 9])).to be nil
      end
    end
  end

  # describe '#get_square' do
  #   context 'when given coordinates that point to a valid square in hash' do
  #     it 'returns the square' do
  #       square_returned = chess_tester.get_square(['a', 1])
  #       expect(square_returned.data).to eq([1, 8])
  #     end
  #   end
  # end

  # describe '#occupied?' do
  #   context 'when given a square housing a friendly piece' do
  #     let(:my_knight) { Knight.new }
  #     let(:my_other_knight) { Knight.new }
  #     let(:square) { double(Square, piece: my_other_knight) }
  #     let(:coord) { ['b', 5] }

  #     before do
  #       allow(chess_tester).to receive(:get_square).with(coord).and_return(square)
  #     end
      
  #     it 'returns true' do
  #       expect(chess_tester.occupied?(my_knight, coord)).to be true
  #     end
  #   end

  #   context 'when given coordinates for an empty square' do
  #     let(:my_knight) { Knight.new }
  #     let(:square) { double(Square, piece: nil) }
  #     let(:coord) { ['b', 5] }

  #     before do
  #       allow(chess_tester).to receive(:get_square).with(coord).and_return(square)
  #     end

  #     it 'returns true' do
  #       expect(chess_tester.occupied?(my_knight, coord)).to be true
  #     end
  #   end
  # end

  describe '#legal_move?' do
    let(:knight)    { Knight.new("black") }
    let(:fr_knight) { Knight.new("black") }
    let(:en_knight) { Knight.new("white") }

    let(:square)        { double(Square, piece: knight)}
    let(:empty_square)  { double(Square, piece: nil)}
    let(:fr_square)     { double(Square, piece: fr_knight)}
    let(:en_square)     { double(Square, piece: en_knight)}

    let(:start_position)  { ['b', 8] }
    let(:end_position)    { ['a', 6] }
    let(:out_of_bounds)   { ['a', 10] }

    context 'when moving a piece on the board' do
      context 'when the ending position is within the board, unoccupied 
      by a friendly, and a possible move for the piece' do

      before do
        allow(chess_tester).to receive(:get_square).and_return(square, empty_square)
        allow(chess_tester).to receive(:puts)
      end

        it 'returns true' do
          expect(chess_tester.legal_move?(start_position, end_position)).to be true
        end
      end

      context 'when the ending position is not within the board' do

        before do
          allow(chess_tester).to receive(:puts)
        end

        it 'returns false' do
          expect(chess_tester.legal_move?(start_position, out_of_bounds)).to be false
        end
      end

      context 'when the ending position is occupied by a friendly' do

        before do
          allow(chess_tester).to receive(:get_square).and_return(square, fr_square)
          allow(chess_tester).to receive(:puts)
        end

        it 'returns false' do
          expect(chess_tester.legal_move?(start_position, end_position)).to be false
        end
      end

      context 'when the ending position is not legal for the piece' do
        it 'returns false' do
          expect(chess_tester.legal_move?(start_position, ['d', 5])).to be false
        end
      end
    end
  end
  
  describe '#move_piece' do
    context 'when moving a piece from one square to another' do
      let(:knight)          { Knight.new }
      let(:friendly_knight) { Knight.new }
      let(:enemy_knight)    { Knight.new("white") }

      let(:starting_square)  { Square.new }
      let(:empty_square)     { Square.new }
      let(:friendly_square)  { Square.new }
      let(:enemy_square)     { Square.new }

      before do
        starting_square.piece = knight
        empty_square.piece    = nil
        friendly_square.piece = friendly_knight
        enemy_square.piece    = enemy_knight
        chess_tester.board    = board_hash
      end

      let(:starting_pos)  { ['b', 8] }
      let(:empty_pos)     { ['a', 6] }
      let(:friendly_pos)  { ['d', 7] }
      let(:enemy_pos)     { ['c', 6] }

      let(:board_hash) { {
        'b' => { 8 => starting_square },
        'a' => { 6 => empty_square },
        'd' => { 7 => friendly_square },
        'c' => { 6 => enemy_square },
      } }

      context 'if it is an empty square' do
        it 'removes the piece from the first square, and places it into the new square' do
          expect { chess_tester.move_piece(starting_pos, empty_pos) }
          .to change { starting_square.piece }
          .from(knight).to(nil)
          .and change { empty_square.piece }
          .from(nil).to(knight)
        end
      end

      context 'if square has an enemy piece' do
        it 'replaces it with knight' do
          expect { chess_tester.move_piece(starting_pos, enemy_pos) }
          .to change { enemy_square.piece }
          .from(enemy_knight).to(knight)
        end
      end
    end
  end

  # describe '#intro_str' do
  # end

  # describe '#game_loop' do
  # end
end