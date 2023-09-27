require './lib/Chess.rb'

class Pieces < Chess
  attr_accessor :attack
  attr_reader :moves, :side, :name, :identifier

  def initialize(identifier = nil, side = nil, name = nil, moves = nil, attack = nil, unicode = nil)
    @side = side
    @name = name
    @moves = moves
    @attack = attack
    @unicode = unicode
    @identifier = identifier
  end
  
  def to_s
    @name
  end

  def to_uni
    @unicode.encode('utf-8')
  end 

  def create(colour, name, identifier = nil)
    case name
    when "rook"
      piece = Rook.new(colour, identifier) 
    when "knight"
      piece = Knight.new(colour, identifier)
    when "bishop"
      piece = Bishop.new(colour, identifier)
    when "queen"
      piece = Queen.new(colour, identifier)
    when "king"
      piece = King.new(colour, identifier)
    when "pawn"
      piece = Pawn.new(colour, identifier)
    end
    piece
  end

end

class Pawn < Pieces
  def initialize(side = "black", identifier = nil)
    moves = [[0, 1]]
    attack = [[-1, 1], [1, 1]]
    unicode = "\u2659"

    if side == "black"
      moves = [[0, -1]]
      attack = [[1, -1], [-1, -1]]
      unicode = "\u265F"
    end

    super(identifier, side, "pawn", moves, attack, unicode)
  end
end

class Knight < Pieces
  def initialize(side = "black", identifier = nil)
    moves = [[1, 2], [2, 1], [1, -2], [2, -1], [-1, 2], [-2, 1], [-1, -2], [-2, -1]]
    unicode = "\u2658"
    unicode = "\u265E" if side == "white"

    super(identifier, side, "knight", moves, moves, unicode)
  end
end

class Rook < Pieces
  def initialize(side = "black", identifier = nil)
    moves = generate_moves
    unicode = "\u2656"
    unicode = "\u265C" if side == "white"

    super(identifier, side, "rook", moves, moves, unicode)
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
  def initialize(side = "black", identifier = nil)
    moves = generate_moves
    unicode = "\u2657"
    unicode = "\u265D" if side == "white"

    super(identifier, side, "bishop", moves, moves, unicode)
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
  def initialize(side = "black", identifier = nil)
    moves = generate_moves
    unicode = "\u2657"
    unicode = "\u265D" if side == "white"
    
    super(identifier, side, "queen", moves, moves, unicode)
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
  def initialize(side = "black", identifier = nil)
    moves = generate_moves
    unicode = "\u2654"
    unicode = "\u265A" if @side == "white"
    super(identifier, side, "king", moves, moves, unicode)
  end

  def generate_moves
    eight_dir = [[-1, 0], [-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1]]
  end
end

# class Pieces < Chess
#   attr_accessor :attack
#   attr_reader :possible_moves, :side, :name

#   def initialize(side = nil, name = nil)
#     @name = "#{side} #{name}"
#     @side = side
#     @possible_moves = generate_moves()
#     @attack = possible_moves
#     @unicode = nil
#   end
  
#   def to_s
#     @name
#   end

#   def to_uni
#     @unicode.encode('utf-8')
#   end

#   def default_pieces
#     pieces = []

#     pieces << create_piece("rook", "black", "left")
#     pieces << create_piece("rook", "black", "right")
#     pieces << create_piece("rook", "white", "left")
#     pieces << create_piece("rook", "white", "right")

#     pieces << create_piece("knight", "black", "left")
#     pieces << create_piece("knight", "black", "right")
#     pieces << create_piece("knight", "white", "left")
#     pieces << create_piece("knight", "white", "right")

#     pieces << create_piece("black", "bishop", "left")
#     pieces << create_piece("black", "bishop", "right")
#     pieces << create_piece("white", "bishop", "left")
#     pieces << create_piece("white", "bishop", "right")

#     pieces << create_piece("queen", "black")
#     pieces << create_piece("queen", "white")

#     pieces << create_piece("king", "black")
#     pieces << create_piece("king", "white")

#     for i in (1..8)
#       letters = %w(a b c d e f g h)
#       pieces << create_piece("black", "pawn", letters[i-1])
#       pieces << create_piece("white", "pawn",letters[i-1])
#     end

#     pieces
#   end
  
#   def generate_moves
#     return nil
#   end

#   def can_move?(old_pos, new_pos)
#     old_pos = convert_from_chess(old_pos)
#     new_pos = convert_from_chess(new_pos)

#     @possible_moves.any? { |pos_move| move(old_pos, pos_move) == new_pos } ? true : false
#   end

#   def can_attack?(old_pos, new_pos)
#     can_move?(old_pos, new_pos)
#   end

#   def create(colour, name, side = nil)
#     case name
#     when "rook"
#       piece = Rook.new(colour, "#{side} #{name}") 
#     when "knight"
#       piece = Knight.new(colour, "#{side} #{name}")
#     when "bishop"
#       piece = Bishop.new(colour, "#{side} #{name}")
#     when "queen"
#       piece = Queen.new(colour)
#     when "king"
#       piece = King.new(colour)
#     when "pawn"
#       piece = Pawn.new(colour, "#{side} #{name}")
#     end
#     piece
#   end
# end

# class Knight < Pieces
#   def initialize(side = "black", name = "knight")
#     super(side, name)
#     @unicode = "\u2658"
#     @unicode = "\u265E" if @side == "black"
#   end

#   def generate_moves
#     [[1, 2], [2, 1], [1, -2], [2, -1], [-1, 2], [-2, 1], [-1, -2], [-2, -1]]
#   end
# end

# class Pawn < Pieces

#   def initialize(side = "black", name = "pawn")
#     super(side, name)
#     @attack = [[-1, 1], [1, 1]]
#     @attack = [[1, -1], [-1, -1]] if @side == "white"
#     @unicode = "\u2659"
#     @unicode = "\u265F" if @side == "black"
#   end

#   def generate_moves
#     if @side == "black"
#       [[0, 1]]
#     elsif @side == "white"
#       [[0, -1]]
#     else
#       puts "#{@side} is an invalid param"
#     end
#   end

#   def can_attack?(old_pos, new_pos)
#     old_pos = convert_from_chess(old_pos)
#     new_pos = convert_from_chess(new_pos)

#     @attack.any? { |att_move| move(old_pos, att_move) == new_pos } ? true : false
#   end
# end

# class Rook < Pieces
#   def initialize(side = "black", name = "rook")
#     super(side, name)
#     @unicode = "\u2656"
#     @unicode = "\u265C" if @side == "black"
#   end

#   def generate_moves
#     full_movement = []

#     curr_w = 1
#     curr_h = 1

#     while curr_w <= 8 && curr_h <= 8
#       full_movement << [curr_w, 0]
#       full_movement << [-curr_w, 0]
#       full_movement << [0, curr_h]
#       full_movement << [0, -curr_h]
#       curr_w += 1
#       curr_h += 1
#     end
    
#     full_movement = full_movement.uniq
#     full_movement
#   end
# end

# class Bishop < Pieces
#   def initialize(side = "black", name = "bishop")
#     super(side, name)
#     @unicode = "\u2657"
#     @unicode = "\u265D" if @side == "black"
#   end

#   def generate_moves
#     full_movement = []
#     curr_w = 1
#     curr_h = 1

#     while curr_w <= 8 && curr_h <= 8
#       full_movement << [curr_w, curr_h]
#       full_movement << [-curr_w, curr_h]
#       full_movement << [curr_w, -curr_h]
#       full_movement << [-curr_w, -curr_h]
#       curr_w += 1
#       curr_h += 1
#     end
    
#     full_movement = full_movement.uniq
#     full_movement
#   end
# end

# class Queen < Pieces
#   def initialize(side = "black")
#     super(side, "queen")
#     @unicode = "\u2655"
#     @unicode = "\u265B" if @side == "black"
#   end

#   def generate_moves
#     full_movement = []
#     curr_w = 1
#     curr_h = 1

#     while curr_w <= 8 && curr_h <= 8
#       full_movement << [curr_w, 0]
#       full_movement << [-curr_w, 0]
#       full_movement << [0, curr_h]
#       full_movement << [0, -curr_h]
#       full_movement << [curr_w, curr_h]
#       full_movement << [-curr_w, curr_h]
#       full_movement << [curr_w, -curr_h]
#       full_movement << [-curr_w, -curr_h]
#       curr_w += 1
#       curr_h += 1
#     end
    
#     full_movement = full_movement.uniq
#     full_movement
#   end
# end

# class King < Pieces
#   def initialize(side = "black")
#     super(side, "king")
#     @unicode = "\u2654"
#     @unicode = "\u265A" if @side == "black"
#   end

#   def generate_moves
#     eight_dir = [[-1, 0], [-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1]]
#   end
# end