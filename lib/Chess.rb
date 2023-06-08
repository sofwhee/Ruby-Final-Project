require 'Board.rb'
require 'Pieces.rb'

class Chess
  
  attr_accessor :board
  
  def initialize
    @board = build_board
    @player = 1
    @turn_count = 1
  end

  def build_board
    # Create hash of squares
    board_hash = {}
    column_letters = %w(a b c d e f g h)
    
    for column in (1..8)
      letter = column_letters[column - 1]
      board_hash[letter] = {}
      for row in (1..8)
        board_hash[letter][row] = Square.new([column, 9 - row])
      end
    end

    board_hash
	end

  def intro_str
    puts "Welcome to Chess!"
    puts "This is a 2 player board game."
  end

  def set_pieces
    @board['a'][8].piece = Rook.new("black")
    @board['h'][8].piece = Rook.new("black")
    @board['a'][1].piece = Rook.new("black")
    @board['h'][1].piece = Rook.new("black")

    @board['b'][8].piece = Knight.new("black")
    @board['g'][8].piece = Knight.new("black") 
    @board['b'][1].piece = Knight.new("white") 
    @board['g'][1].piece = Knight.new("white")

    @board['b'][8].piece = Bishop.new("black")
    @board['b'][8].piece = Bishop.new("black") 
    @board['b'][8].piece = Bishop.new("white")
    @board['b'][8].piece = Bishop.new("white")

    @board['b'][8].piece = Queen.new("black") 
    @board['b'][8].piece = Queen.new("white") 

    @board['b'][8].piece = King.new("black")
    @board['b'][8].piece = King.new("white")

    for i in (1..8)
      letters = %w(a b c d e f g h)
      @board[letters[i-1]][7].piece = Pawn.new("black")
      @board[letters[i-1]][2].piece = Pawn.new("white")
    end
  end

  def convert_from_chess(position)
    letters = %w(a b c d e f g h)
    convert_letter = letters.find_index(position[0]) + 1
    [convert_letter, 9 - position[1]]
  end

  def convert_to_chess(position)
    letters = %w(a b c d e f g h)
    convert_number = letters[position[0] - 1]
    [convert_number, 9 - position[1]]
  end

  def get_square(coord)
    @board[coord[0]][coord[1]]
  end

  def move(a, b)
		a = [a[0] + b[0], a[1] + b[1]]
	end

  def no_piece?(coord)
    get_square(coord).piece ? true : puts("There is no piece at #{coord}.")
  end

  def within_board?(new_coord)
    new_coord = convert_from_chess(new_coord)
    (new_coord[0].between?(1, 8) && new_coord[1].between?(1, 8)) ? true : puts("#{new_coord} does not exist on the board.")
  end

  def piece_can_move?(piece, start_coord, new_coord)
    piece.can_move?(start_coord, new_coord)
  end

  def available_square?(piece, other_piece)
    piece.side != other_piece.side ? true : puts("#Occupied by a friendly piece.")
  end

  def legal_move?(start_coord, new_coord)
    piece = get_square(start_coord).piece
    other_piece = get_square(start_coord).piece

    return false if !within_board?(new_coord)
    return false if !piece
    return false if !piece_can_move?(piece, start_coord, new_coord)
    return true  if !other_piece
    return false if !available_square?(piece, other_piece)
    true
  end

  def move_piece(start_coord, end_coord)
    get_square(end_coord).piece = get_square(start_coord).piece
    get_square(start_coord).piece = nil
  end

  def how_many_moves(moves_array, root, destination)
    moves = movement_path(moves_array, root, destination)
    move_message(moves)
  end

	def movement_path(moves_array, root, destination)
    # returns a message with shortest movement path and number of moves
		queue = [Square.new(root)]

		found = false
		while !found
			move_path_tree(queue.first, moves_array)

			for child in queue.first.children
				queue << child
			 	if child.data == destination
					found = true
					break
				end
			end
			
			queue.shift
		end

		moves_made = return_lineage(queue.last)
	end

  def move_message(moves_made)
    puts "You made it in #{moves_made.size - 1} moves! Here's your path: #{moves_made}"
  end

	def move_path_tree(root_square, moves_array)
    # creates a tree from possible moves
		for movement in moves_array
			new_position = move(root_square.data, movement)

			if legal_move?(new_position) && !root_square.has_parent?(new_position)
				root_square.children << Square.new(new_position, root_square)
			end
		end
	end

	def return_lineage(square)
    # returns lineage of movement child
		parents = [square]
		while parents.first.parent
			parents = parents.unshift(parents.first.parent)
		end
		parents.map {|par| par.data}
	end

  def game_loop
    until game_over? do
      start_turn
      pl_input = take_input
      command = game_command(pl_input)
      game_response(game_command)
    end
  end

  def start_turn
    puts "#{@player} player, it is now your turn."
  end

  def take_input
    raw_input = gets.chomp
  end

  def game_command(command)
  end

  def switch_turns
    if @player == 1
      @player = 2
    else
      @player = 1
    end
  end

  def validate_move(piece, destination)
  end

  def illegal_move(move)
    puts "#{move} is an illegal move!"
  end

  def remove_piece
  end

  def check
  end

  def checkmate
  end

  def game_ends
  end

end