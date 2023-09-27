
class Chess

  @@chess_letters = %w(a b c d e f g h)
  @@player = "white"

  def get_player
    @@player
  end

  def get_enemy_player
    enemy_colour = @@player == "white" ? "black" : "white"
  end

  def switch_player
    @@player == "black" ? @@player = "white" : @@player = "black"
  end

  def convert_from_chess(position)
    convert_letter = @@chess_letters.find_index(position[0]) + 1
    [convert_letter, 9 - position[1].to_i]
  end

  def convert_to_chess(position)
    convert_number = @@chess_letters[position[0] - 1]
    [convert_number, (9 - position[1]).to_s]
  end

  def move(a, b)
		a = [a[0] + b[0], a[1] + b[1]]
	end
end