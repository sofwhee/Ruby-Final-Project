require './lib/Chess.rb'
require './lib/Pieces.rb'
require './lib/Square.rb'

class ChessBoard < Chess
  
  attr_accessor :board
  attr_reader   :pieces_on_board
  
  def initialize
    @board = build_board
    @pieces_on_board = []
  end

  def build_board
    # Create hash of squares
    board_hash = {
      "a" => [], 
      "b" => [], 
      "c" => [], 
      "d" => [], 
      "e" => [], 
      "f" => [], 
      "g" => [], 
      "h" => []
    }

    for letter, value in board_hash
      for row in (1..8)
        board_hash[letter].append(Square.new([letter, (0 + row).to_s]))
      end
    end

    board_hash
	end

  def board_to_sq
    squares = []
    board_length = 8

    board_length.downto(1) do |num|
      for letter in @board.keys
        square = @board[letter][num - 1]
        squares << square
      end
    end

    squares
  end

  def squares_uni_str
    board_str = ""
    board_to_sq.each { |sq| board_str = board_str + sq.to_uni }
    board_str
  end

  def sq_unis_to_board
    new_board = ""

    hor = 1
    vert = 1

    for sq in board_to_sq()
      new_board = new_board + "#{9 - vert} |" if hor == 1

      new_board = new_board + sq.to_uni
      
      if hor == 8
        new_board = new_board + "|\n" 
        hor = 1
        vert += 1
      else
        new_board = new_board + "|"
        hor += 1
      end
    end

    new_board[-1] = ""
    new_board
  end

  def to_s
    board_str = <<~BOARD
       a b c d e f g h
       _ _ _ _ _ _ _ _
    #{sq_unis_to_board}
    BOARD
  end  

  def clear_board
    @pieces_on_board = []
    @board = build_board
  end

  def get_square(letter, row)
    @board[letter][row - 1]
  end

  def get_piece_square(side, name, identifier = nil)
    piece_square = nil
    for sq in board_to_sq()
      next if !sq.piece

      if sq.piece.side == side && \
        sq.piece.name == name && \
        sq.piece.identifier == identifier
        
        piece_square = sq
        break
      end
    end
    piece_square
  end

  def get_piece_squares(pieces_list)
    pieces_list.map { |piece| get_piece_square(piece.side, piece.name, piece.identifier) }
  end

  def array_to_squares(coord_array)
    coord_array.map { |coord| get_square(coord[0], coord[1]) }
  end

  def path_to_squares(coords_array)
    coords_array  = coords_array.map { |coord| convert_to_chess(coord) }
    coords_array  = coords_array.map { |coord| coord = [coord[0], coord[1].to_i] }
    path          = array_to_squares(coords_array)
  end

  def side_pieces(side)
    @pieces_on_board.select { |piece| piece.side == side }
  end

  def add_piece(column, row, piece)
    @board[column][row - 1].piece = piece
    @pieces_on_board << piece
  end

  def move_piece(start_sq, end_sq)
    piece = end_sq.piece

    remove_piece(piece.side, piece.name, piece.identifier) if end_sq.piece

    end_sq.piece = start_sq.piece

    start_sq.piece = nil
  end

  def remove_piece(side, name, identifier)
    square = get_piece_square(side, name, identifier)
    piece = square.piece
    @pieces_on_board.delete(piece)
    square.piece = nil
  end

end