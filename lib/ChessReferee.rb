require_relative 'Chess'

class ChessReferee < Chess

  def initialize()
  end

  def piece?(piece, coord)
    return true if piece
    puts "#{coord} does not have a piece to move."
  end

  def friendly_piece?(piece, start_coord, player)
    return true if player == piece.side
    puts "#{start_coord}'s #{piece.name} is not owned by player #{player}."
  end

  def unoccupied?(piece, other_piece)
    return true if !other_piece || piece.side != other_piece.side
    puts("The destination square is occupied by a friendly piece.")
  end

  def movement_path(start_coord, last_coord)    
    movement_path = []
    coord = start_coord
    while coord != last_coord
      case coord[0] <=> last_coord[0]
      when -1
        coord[0] = coord[0] + 1
      when 1
        coord[0] = coord[0] - 1
      end

      case coord[1] <=> last_coord[1]
      when -1
        coord[1] = coord[1] + 1
      when 1
        coord[1] = coord[1] - 1
      end

      movement_path << [coord[0], coord[1]]
    end

    movement_path.pop
    movement_path
  end

  def get_path_squares(board, coord_array)
    board.path_to_squares(coord_array)
  end

  def pieces_in_path(board, start_square, last_square)
    start, last = convert_from_chess(start_square.data), convert_from_chess(last_square.data)
    coord_path = movement_path(start, last)
    path_squares = get_path_squares(board, coord_path)
    return true if path_squares.any? { |sq| sq.piece != nil}
    false
  end

  def path_clear?(piece, board, start_square, last_square)
    # if the piece moves in a long line
    if piece.name.include?("rook") \
      || piece.name.include?("bishop") \
      || piece.name.include?("queen") 
      # check if there are pieces in the way
      return false if pieces_in_path(board, start_square, last_square)
    end
    true
  end

  def piece_can_move?(piece, start_coord, new_coord)
    old_pos = convert_from_chess(start_coord)
    new_pos = convert_from_chess(new_coord)

    piece.moves.any? { 
      |pos_move| move(old_pos, pos_move) == new_pos 
      } ? true : false
  end

  def piece_can_attack?(piece, start_coord, new_coord)
    old_pos = convert_from_chess(start_coord)
    new_pos = convert_from_chess(new_coord)

    piece.attack.any? { 
      |pos_move| move(old_pos, pos_move) == new_pos 
      } ? true : false
  end

  def legal_move?(start_square, new_square, player, board)
    # Expects both args to be chess coords.
    # ['a', '7'], ['b', '9']
    return false if !start_square || !new_square

    piece, other_piece = start_square.piece, new_square.piece
    start_coord, new_coord = start_square.data, new_square.data

    return false if !piece?(piece, start_coord) \
      || !friendly_piece?(piece, start_coord, player)  \
      || !unoccupied?(piece, other_piece)

    if other_piece
      return false if !piece_can_attack?(piece, start_coord, new_coord) \
      || !path_clear?(piece, board, start_square, new_square)
    else
      return false if !piece_can_move?(piece, start_coord, new_coord) \
      || !path_clear?(piece, board, start_square, new_square)
    end

    true
  end
end