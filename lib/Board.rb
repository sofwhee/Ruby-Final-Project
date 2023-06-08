require_relative 'Square'

class Board
	attr_accessor :board_hash

	def initialize()
		@board_hash = build_board 
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

	# def move(a, b)
	# 	a = [a[0] + b[0], a[1] + b[1]]
	# end

  # def how_many_moves(moves_array, root, destination)
  #   moves = movement_path(moves_array, root, destination)
  #   move_message(moves)
  # end

	# def movement_path(moves_array, root, destination)
  #   # returns a message with shortest movement path and number of moves
	# 	queue = [Square.new(root)]

	# 	found = false
	# 	while !found
	# 		move_path_tree(queue.first, moves_array)

	# 		for child in queue.first.children
	# 			queue << child
	# 		 	if child.data == destination
	# 				found = true
	# 				break
	# 			end
	# 		end
			
	# 		queue.shift
	# 	end

	# 	moves_made = return_lineage(queue.last)
	# end

  # def move_message(moves_made)
  #   puts "You made it in #{moves_made.size - 1} moves! Here's your path: #{moves_made}"
  # end

	# def move_path_tree(root_square, moves_array)
  #   # creates a tree from possible moves
	# 	for movement in moves_array
	# 		new_position = move(root_square.data, movement)

	# 		if legal_move?(new_position) && !root_square.has_parent?(new_position)
	# 			root_square.children << Square.new(new_position, root_square)
	# 		end
	# 	end
	# end

	# def return_lineage(square)
  #   # returns lineage of movement child
	# 	parents = [square]
	# 	while parents.first.parent
	# 		parents = parents.unshift(parents.first.parent)
	# 	end
	# 	parents.map {|par| par.data}
	# end

end