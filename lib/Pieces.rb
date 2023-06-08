class Pieces
  attr_accessor :attack, :all_pieces
  attr_reader :possible_moves, :side

  @@all_pieces = []

  def initialize(name = nil, side = "black")
    @name = "#{side} #{name}"
    @side = side
    @possible_moves = generate_moves()
    @attack = possible_moves    
    @@all_pieces << self
  end
  
  def to_s
    @name
  end

  def self.all_pieces
    @@all_pieces
  end

  def self.clear_all_pieces
    @@all_pieces = []
  end

  def generate_moves
    return nil
  end

  def convert_from_chess(position)
    letters = %w(a b c d e f g h)
    convert_letter = letters.find_index(position[0]) + 1
    [convert_letter, 9 - position[1]]
  end

  def move(a, b)
		a = [a[0] + b[0], a[1] + b[1]]
	end

  def can_move?(old_pos, new_pos)
    old_pos = convert_from_chess(old_pos)
    new_pos = convert_from_chess(new_pos)

    @possible_moves.any? { |pos_move| move(old_pos, pos_move) == new_pos } ? true : puts("That piece cannot move that way.")
  end
end

class Knight < Pieces
  def initialize(side = "black")
    super("knight", side)
  end

  def generate_moves
    [[1, 2], [2, 1], [1, -2], [2, -1], [-1, 2], [-2, 1], [-1, -2], [-2, -1]]
  end
end

class Pawn < Pieces

  def initialize(side = "black")
    super("pawn", side)
    @attack = [[-1, 1], [1, 1]]
    @attack = [[1, -1], [-1, -1]] if @side == "white"
  end

  def generate_moves
    if @side == "black"
      [[0, 1]]
    elsif @side == "white"
      [[0, -1]]
    else
      puts "#{@side} is an invalid param"
    end
  end
end

class Rook < Pieces
  def initialize(side = "black")
    super("rook", side)
  end

  def generate_moves
    full_movement = []

    curr_w = 1
    curr_h = 1

    while curr_w <= 8 && curr_h <= 8
      full_movement << [curr_w, 0]
      full_movement << [-curr_w, 0]
      full_movement << [0, curr_h]
      full_movement << [0, -curr_h]
      curr_w += 1
      curr_h += 1
    end
    
    full_movement = full_movement.uniq
    full_movement
  end
end

class Bishop < Pieces
  def initialize(side = "black")
    super("bishop", side)
  end

  def generate_moves
    full_movement = []
    curr_w = 1
    curr_h = 1

    while curr_w <= 8 && curr_h <= 8
      full_movement << [curr_w, curr_h]
      full_movement << [-curr_w, curr_h]
      full_movement << [curr_w, -curr_h]
      full_movement << [-curr_w, -curr_h]
      curr_w += 1
      curr_h += 1
    end
    
    full_movement = full_movement.uniq
    full_movement
  end
end

class Queen < Pieces
  def initialize(side = "black")
    super("queen", side)
  end

  def generate_moves
    full_movement = []
    curr_w = 1
    curr_h = 1

    while curr_w <= 8 && curr_h <= 8
      full_movement << [curr_w, 0]
      full_movement << [-curr_w, 0]
      full_movement << [0, curr_h]
      full_movement << [0, -curr_h]
      full_movement << [curr_w, curr_h]
      full_movement << [-curr_w, curr_h]
      full_movement << [curr_w, -curr_h]
      full_movement << [-curr_w, -curr_h]
      curr_w += 1
      curr_h += 1
    end
    
    full_movement = full_movement.uniq
    full_movement
  end
end

class King < Pieces
  def initialize(side = "black")
    super("king", side)
  end

  def generate_moves
    eight_dir = [[-1, 0], [-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1]]
  end
end