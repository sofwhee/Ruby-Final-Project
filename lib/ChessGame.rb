require './lib/Pieces.rb'
require './lib/ChessBoard.rb'
require './lib/ChessReferee.rb'

class ChessGame < Chess

  attr_reader :player

  def initialize(
    board = ChessBoard.new, 
    pieces_manager = Pieces.new, 
    referee = ChessReferee.new)

    @board = board
    @pieces = pieces_manager
    @referee = referee

    @valid_commands = ['quit', 'move']
    @intro_str = "Welcome to Chess!\nThis is a 2 player board game."
  end

  def set_pieces
    @board.add_piece('a', 8, @pieces.create("black", "rook", "left"))
    @board.add_piece('h', 8, @pieces.create("black", "rook", "right"))
    @board.add_piece('b', 8, @pieces.create("black", "knight", "left"))
    @board.add_piece('g', 8, @pieces.create("black", "knight", "right"))
    @board.add_piece('c', 8, @pieces.create("black", "bishop", "left"))
    @board.add_piece('f', 8, @pieces.create("black", "bishop", "right"))
    @board.add_piece('d', 8, @pieces.create("black", "queen"))
    @board.add_piece('e', 8, @pieces.create("black", "king"))
    @board.add_piece('a', 7, @pieces.create("black", "pawn", "a"))
    @board.add_piece('b', 7, @pieces.create("black", "pawn", "b"))
    @board.add_piece('c', 7, @pieces.create("black", "pawn", "c"))
    @board.add_piece('d', 7, @pieces.create("black", "pawn", "d"))
    @board.add_piece('e', 7, @pieces.create("black", "pawn", "e"))
    @board.add_piece('f', 7, @pieces.create("black", "pawn", "f"))
    @board.add_piece('g', 7, @pieces.create("black", "pawn", "g"))
    @board.add_piece('h', 7, @pieces.create("black", "pawn", "h"))

    @board.add_piece('a', 1, @pieces.create("white", "rook", "left"))
    @board.add_piece('h', 1, @pieces.create("white", "rook", "right"))
    @board.add_piece('b', 1, @pieces.create("white", "knight", "left"))
    @board.add_piece('g', 1, @pieces.create("white", "knight", "right"))
    @board.add_piece('c', 1, @pieces.create("white", "bishop", "left"))
    @board.add_piece('f', 1, @pieces.create("white", "bishop", "right"))
    @board.add_piece('d', 1, @pieces.create("white", "queen"))
    @board.add_piece('e', 1, @pieces.create("white", "king"))
    @board.add_piece('a', 2, @pieces.create("white", "pawn", "a"))
    @board.add_piece('b', 2, @pieces.create("white", "pawn", "b"))
    @board.add_piece('c', 2, @pieces.create("white", "pawn", "c"))
    @board.add_piece('d', 2, @pieces.create("white", "pawn", "d"))
    @board.add_piece('e', 2, @pieces.create("white", "pawn", "e"))
    @board.add_piece('f', 2, @pieces.create("white", "pawn", "f"))
    @board.add_piece('g', 2, @pieces.create("white", "pawn", "g"))
    @board.add_piece('h', 2, @pieces.create("white", "pawn", "h"))
  end

  def take_input_and_clean
    raw_input = gets.chomp.downcase.gsub(",", "")
  end

  def coords_in_string(input_string)
    # collect phrases that are 2 characters long
    string_array = input_string.split()
    string_array.select { |word| word.length == 2 && @@chess_letters.include?(word[0]) && word[1].to_i.to_s == word[1] }
  end

  def extract_coords(input_string)
    # return usable coordinates from a string

    # Check if two coords given
    coords = coords_in_string(input_string)

    if coords.length != 2
      puts "#{input_string} wasn't given two valid coordinates. Valid coordinates given: #{coords}"
      return nil
    end

    # Check if coords are within chess board
    coord1, coord2 = coords.first, coords.last
    
    if !@@chess_letters.include?(coord1[0])
      puts "#{coord1[0]} is not a letter on the chess board."
      return nil
    elsif !@@chess_letters.include?(coord2[0])
      puts "#{coord2[0]} is not a letter on the chess board."
      return nil
    elsif !coord1[1].to_i.between?(1, 8)
      puts "#{coord1[1]} is not a number within the bounds of the chess board."
      return nil
    elsif !coord2[1].to_i.between?(1, 8)
      puts "#{coord2[1]} is not a number within the bounds of the chess board."
      return nil
    end

    return [[coord1[0], coord1[1]], [coord2[0], coord2[1]]]
  end

  def checking_squares(king_square, friendly_squares)
    friendly_squares.select { 
      |square| @referee.piece_can_move?(square.piece, square.data, king_square.data) 
    }
  end

  def checking_pieces_string(checking_squares)
    string = ""
    counter = 0
    for square in checking_squares
      string = string + "," if counter != 0
      string = string + " a #{square.piece.side} #{square.piece.name} at #{square.data}"
      counter += 1
    end
    string = string + "."
    string
  end

  def check_message(checking_squares)
    "#{get_enemy_player}'s king has been checked by" + checking_pieces_string(checking_squares)
  end

  def check?(king_square = @board.get_piece_square("#{get_enemy_player}", "king"))
    # Checks if the board represents a check against the enemy player. 
    friendly_squares = @board.get_piece_squares(@board.side_pieces(get_player))
    checking_squares = checking_squares(king_square, friendly_squares)
    return false if checking_squares == []
    check_message(checking_squares)
    checking_squares
  end

  def make_sq_double(square)
    square_double = Square.new(square.data)
    square_double.piece = square.piece
    square_double
  end

  def king_escapes(king_root)
    king_root_double = make_sq_double(king_root)
    move_path_tree(king_root_double, get_enemy_player)
    king_root_double.children
  end

  def checkmate?
    # check for checkmate
    # create tree of possible moves king can make

    king_square = @board.get_piece_square("#{get_enemy_player}", "king")
    
    if !king_square 
      puts "#{get_enemy_player} king is nil!"
      return false
    end

    # collect escape routes into list
    possible_escapes = king_escapes(king_square)

    # assess the viability of all escapes
    pieces_to_check = @board.side_pieces(get_player)
    possible_escapes.all? { |escape| check?(escape) }

  end

  def move_path_tree(root_square, player)
    # creates a tree from possible moves
    moves_array = root_square.piece.moves
    
		for movement in moves_array
			new_position = move(convert_from_chess(root_square.data), movement)
      new_position = convert_to_chess(new_position)
      new_square = @board.get_square(new_position[0], new_position[1].to_i)
      next if !new_square

			if @referee.legal_move?(root_square, new_square, player, @board)
        new_square = make_sq_double(new_square)
        new_square.piece = root_square.piece
				root_square.children << new_square
			end
		end
	end

  def game_start
    # set up board
    # print intro
    # print instructions
    # print board

    @board.clear_board
    set_pieces()
    puts(@intro_str) 
  end

  def start_turn
    puts "#{get_player}, it is now your turn."
    puts @board
    puts "Type your move: (ie. 'a5 b6')"
  end

  def game_loop
    game_over_state = nil

    loop do
      # Check/Checkmate?
      if check?
        if checkmate?
          game_over_state = "checkmate"
          break
        end
      end
      
      puts "loop start"
      start_turn

      # take input
      pl_input = take_input_and_clean

      player_quit = pl_input.split().include?(@valid_commands[0])
      if player_quit
        game_over_state = "quit"
        break
      end

      coords = extract_coords(pl_input)
      next if !coords
      
      # validate input
      start_square, new_square = @board.get_square(coords[0][0], coords[0][1].to_i), @board.get_square(coords[1][0], coords[1][1].to_i)
      next if !@referee.legal_move?(start_square, new_square, get_player, @board)

      # complete move
      if check?
        if valid_uncheck?(start_square, new_square)
          @board.move_piece(start_square, new_square)
        else
          puts "You cannot keep the king in check! Please uncheck king!"
          next
        end
      else
        @board.move_piece(start_square, new_square)
      end

      # loop with other player
      switch_player

      # Self Check/Checkmate?
      if check?
        if checkmate?
          game_over_state = "checkmate"
          break
        end
      end
    end

    game_over_state
  end

  def game_ends
    puts "Game over! #{get_player} wins!"
  end

end