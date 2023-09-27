require './lib/ChessReferee.rb'
require './lib/Pieces.rb'
require './lib/Square.rb'
require './lib/ChessBoard.rb'

describe ChessReferee do

  subject(:referee_tester) { ChessReferee.new }

  describe '#piece?' do

    context 'when given a piece' do
      it 'returns true' do
        expect(referee_tester.piece?("yes", "45")).to be true
      end
    end

    context 'when given nil' do
      it 'returns nil' do
        expect(referee_tester.piece?(nil, "45")).to be nil
      end
    end
  end

  describe '#friendly_piece?' do

    let(:pl_piece)    { Knight.new() }
    let(:piece_coord) { ["a", "1"] }
    let(:player)      { "black" }
    let(:wrong_player) { "white" }

    context 'if the piece given belongs to the player given' do
      it 'returns true' do
        expect(referee_tester.friendly_piece?(pl_piece, piece_coord, player)).to be true
      end
      
      it 'returns nil' do
        expect(referee_tester.friendly_piece?(pl_piece, piece_coord, player)).to be true
      end
    end
  end

  describe '#unoccupied?' do

    let(:pl_piece) { Knight.new() }
    let(:fr_piece) { Knight.new() }
    let(:en_piece) { Knight.new("white") }

    context 'if both pieces given are on the same side' do
      it 'returns nil' do
        expect(referee_tester.unoccupied?(pl_piece, fr_piece)).to be nil
      end
    end

    context 'if both pieces are on different sides' do
      it 'returns true' do
        expect(referee_tester.unoccupied?(pl_piece, en_piece)).to be true
      end
    end
  end

  describe '#movement_path' do
    context 'When given [1, 1] and [1, 8]' do
      start = [1, 1]
      last = [1, 8]
      result = [[1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]]

      it 'Returns [[1, 2], [1, 3], [1, 4]... [1, 7]]' do
        expect(referee_tester.movement_path(start, last)).to eq(result)
      end
    end

    context 'When given [1, 1] and [8, 1]' do
      start = [1, 1]
      last = [8, 1]
      result = [[2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1]]

      it 'Returns [[2, 1], [3, 1], [4, 1]... [7, 1]]' do
        expect(referee_tester.movement_path(start, last)).to eq(result)
      end
    end

    context 'When given [1, 1] and [8, 8]' do
      start = [1, 1]
      last = [8, 8]
      result = [[2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
      it 'Returns [[2, 2], [3, 3], [4, 4]... [7, 7]]' do
        expect(referee_tester.movement_path(start, last)).to eq(result)
      end
    end

    context 'When given [8, 8] and [1, 1]' do
      start = [8, 8]
      last = [1, 1]
      result = [[2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
      result = result.reverse
      it 'Returns [[7, 7], [6, 6], [5, 5]... [2, 2]]' do
        expect(referee_tester.movement_path(start, last)).to eq(result)
      end
    end

    context 'When given [1, 8] and [1, 1]' do
      start = [1, 8]
      last = [1, 1]
      result = [[1, 7], [1, 6], [1, 5], [1, 4], [1, 3], [1, 2]]
      it 'Returns [[1, 7], [1, 6], [1, 5]... [1, 2]]' do
        expect(referee_tester.movement_path(start, last)).to eq(result)
      end
    end

    context 'When given [1, 1] and [1, 2]' do
      start = [1, 1]
      last = [1, 2]
      result = []
      it 'Returns []' do
        expect(referee_tester.movement_path(start, last)).to eq(result)
      end
    end
  end

  describe '#get_path_squares' do
    context 'when called' do

      let(:board_tester) { instance_double(ChessBoard) }

      before do
        allow(board_tester).to receive(:path_to_squares)
      end

      it 'sends path_to_squares to board obj' do
        expect(board_tester).to receive(:path_to_squares)
        referee_tester.get_path_squares(board_tester, "test")
      end
    end
  end

  describe '#path_clear?' do

    let(:board_tester)    { ChessBoard.new }

    let(:queen)           { Queen.new("white") }
    let(:start_sq)        { double(Square, piece: queen, data: ['a', '1']) }
    let(:destination_sq)  { double(Square, piece: nil, data: ['d', '4'])}

    context 'When there is a knight in the way of a moving queen' do

      let(:knight)          { Knight.new("white") }

      it 'returns false' do
        board_tester.add_piece('c', '3', knight)
        result = referee_tester.path_clear?(queen, board_tester, start_sq, destination_sq)
        expect(result).to be false
      end
    end

    context 'When there is nothing in the way of a moving queen' do
      it 'returns true' do
        result = referee_tester.path_clear?(queen, board_tester, start_sq, destination_sq)
        expect(result).to be true
      end
    end
  end

  describe '#piece_can_move?' do
    context 'when given a knights moves' do
      context 'when given a valid move' do

        let(:knight)        { Knight.new("white") }
        let(:position)      { ['e', '8' ] }
        let(:new_position)  { ['d', '6' ] }

        it 'sends ".can_move?" call to object' do
          expect(knight).to receive(:can_move?)
          referee_tester.piece_can_move?(knight, position, new_position)
        end
      end
    end
  end

  describe '#pieces_in_path' do

    let(:board_tester) { ChessBoard.new }
    let(:piece_tester) { Pieces.new }
    let(:queen)        { piece_tester.create("black", "queen") }
    let(:knight)       { piece_tester.create("white", "knight") }

    before do
      board_tester.clear_board
      board_tester.add_piece("a", "1", queen)
      board_tester.add_piece("c", "3", knight)
    end

    let(:start)    { instance_double(Square, data: ["a", "1"]) }
    let(:last)     { instance_double(Square, data: ["d", "4"]) }

    context 'When there is a knight in the way' do
      it 'returns true' do
        expect(referee_tester.pieces_in_path(board_tester, start, last)).to be true
      end
    end

    let(:last_two)     { instance_double(Square, data: ["a", "8"]) }

    context 'When there is nothing in the way' do
      it 'returns false' do
        expect(referee_tester.pieces_in_path(board_tester, start, last_two)).to be false
      end
    end
  end

  describe '#piece_can_attack?' do
    context 'when given a white pawn' do
      context 'when given a valid attack' do

        let(:pawn)        { Pawn.new("white") }
        let(:position)      { ['a', '6' ] }
        let(:new_position)  { ['b', '7' ] }

        it 'sends ".can_attack?" call to object' do
          expect(pawn).to receive(:can_attack?)
          referee_tester.piece_can_attack?(pawn, position, new_position)
        end
      end
    end

    context 'when given a black pawn' do
      context 'when given a valid attack' do

        let(:pawn)        { Pawn.new("black") }
        let(:position)      { ['a', '6' ] }
        let(:new_position)  { ['b', '7' ] }

        it 'sends ".can_attack?" call to object' do
          expect(pawn).to receive(:can_attack?)
          referee_tester.piece_can_attack?(pawn, new_position, position)
        end
      end
    end
  end

  describe '#attack_check' do
    context 'when given a valid other_piece' do

      let(:other_pawn)  { Pawn.new("black") }
      let(:pawn)        { Pawn.new("white") }
      let(:position)      { ['a', '3' ] }
      let(:new_position)  { ['b', '4' ] }
      let(:invalid_position)  { ['b', '7' ] }

      context 'when given a pawn with a valid attack movement' do

        it 'sends ".can_attack?" call to object' do
          expect(pawn).to receive(:can_attack?)
          referee_tester.attack_check(other_pawn, pawn, position, new_position)
        end

        it 'returns true' do
          result = referee_tester.attack_check(other_pawn, pawn, position, new_position)
          expect(result).to be true
        end
      end

      context 'when given a pawn with an invalid attack movement' do

        it 'sends ".can_attack?" call to object' do
          expect(pawn).to receive(:can_attack?)
          referee_tester.attack_check(other_pawn, pawn, position, invalid_position)
        end

        it 'returns false' do
          result = referee_tester.attack_check(other_pawn, pawn, position, invalid_position)
          expect(result).to be false
        end
      end
    end
  end

  describe '#legal_move?' do

    let(:board_tester)    { ChessBoard.new }

    context 'when moving a piece on the board' do

      context 'when the ending position is within the board, unoccupied 
      by a friendly, and a possible move for the piece' do

        let(:start_position)  { ['b', '8'] }
        let(:knight)          { Knight.new("white") }
        let(:square)          { double(Square, piece: knight, data: start_position) }

        let(:end_position)    { ['a', '6'] }
        let(:empty_square)    { double(Square, piece: nil, data: end_position) }

        it 'returns true' do
          expect(referee_tester.legal_move?(square, empty_square, "white", board_tester)).to be true
        end
      end

      context 'when the ending position is within the board, unoccupied 
      by a friendly, and a possible attack (but not move) for the piece' do

        let(:pawn_start)      { ['a', '3'] }
        let(:pawn)            { Pawn.new("white") }
        let(:fr_pawn_square)  { double(Square, piece: pawn, data: pawn_start) }

        let(:pawn_attack)     { ['b', '4'] }
        let(:en_pawn)         { Pawn.new("black") }
        let(:en_pawn_square)  { double(Square, piece: en_pawn, data: pawn_attack) }

        it 'returns true' do
          expect(referee_tester.legal_move?(fr_pawn_square, en_pawn_square, "white", board_tester)).to be true
        end
      end

      context 'when the start position doesnt belong to a friendly piece' do

        let(:start_position)  { ['b', '8'] }
        let(:en_knight)       { Knight.new("black") }
        let(:en_square)       { double(Square, piece: en_knight, data: start_position) }
  
        let(:end_position)    { ['a', '6'] }
        let(:empty_square)    { double(Square, piece: nil, data: end_position) }

        it 'returns false' do
          expect(referee_tester.legal_move?(en_square, empty_square, "white", board_tester)).to be false
        end
      end

      context 'when the ending position is occupied by a friendly' do

        let(:start_position)  { ['b', '8'] }
        let(:knight)          { Knight.new("white") }
        let(:square)          { double(Square, piece: knight, data: start_position) }
  
        let(:end_position)    { ['a', '6'] }
        let(:fr_knight)       { Knight.new("white") }
        let(:fr_square)       { double(Square, piece: fr_knight, data: end_position) }

        it 'returns false' do
          expect(referee_tester.legal_move?(square, fr_square, "white", board_tester)).to be false
        end
      end

      context 'when the ending position is not legal for the piece' do

        let(:start_position)  { ['b', '8'] }
        let(:knight)          { Knight.new("white") }
        let(:square)          { double(Square, piece: knight, data: start_position) }
  
        let(:too_far)         { ['g', '2'] }
        let(:far_square)      { double(Square, piece: nil, data: too_far) }

        it 'returns false' do
          expect(referee_tester.legal_move?(square, far_square, "white", board_tester)).to be false
        end
      end
    
      context 'when there is a piece in the way of a moving queen' do

        let(:start_position)  { ['a', '1'] }
        let(:queen)           { Queen.new("white") }
        let(:square)          { double(Square, piece: queen, data: start_position) }
  
        let(:in_the_way_position)   { ['c', '3'] }
        let(:in_the_way_knight)     { Knight.new("white") }
  
        let(:end_position)    { ['d', '4'] }
        let(:empty_square)    { double(Square, piece: nil, data: end_position) }

        it 'returns false' do
          board_tester.clear_board
          board_tester.add_piece('a', '1', queen)
          board_tester.add_piece('c', '3', in_the_way_knight)
          puts board_tester
          expect(referee_tester.legal_move?(square, empty_square, "white", board_tester)).to be false
        end
      end
    
      context 'when there is a piece in the way of a moving rook' do

        let(:start_position)  { ['a', '1'] }
        let(:rook)            { Rook.new("white") }
        let(:square)          { double(Square, piece: rook, data: start_position) }
  
        let(:in_the_way_position)   { ['a', '3'] }
        let(:in_the_way_knight)     { Knight.new("white") }
  
        let(:end_position)    { ['a', '4'] }
        let(:empty_square)    { double(Square, piece: nil, data: end_position) }

        it 'returns false' do
          board_tester.clear_board
          board_tester.add_piece('a', '1', rook)
          board_tester.add_piece('a', '3', in_the_way_knight)
          expect(referee_tester.legal_move?(square, empty_square, "white", board_tester)).to be false
        end
      end
    
      context 'when there is nothing in the way of a moving rook' do

        let(:start_position)  { ['a', '1'] }
        let(:rook)            { Rook.new("white") }
        let(:square)          { double(Square, piece: rook, data: start_position) }
  
        let(:end_position)    { ['a', '4'] }
        let(:empty_square)    { double(Square, piece: nil, data: end_position) }

        it 'returns true' do
          expect(referee_tester.legal_move?(square, empty_square, "white", board_tester)).to be true
        end
      end
    end
  end
end