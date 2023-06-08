class Square
	attr_accessor :data, :parent, :children, :piece

	def initialize(data = nil, parent = nil)
		@data = data
		@parent = parent
		@children = []
    @piece = nil
	end

	def to_s()
		"#{@data} #{@piece}}"
	end

  def convert_pos(position)
    letters = %w(a b c d e f g h)
    convert_letter = letters.find_index(position[0]) + 1
    [convert_letter, position[1]]
  end

	def has_parent?(coord)
		parents = []
		parent = @parent
		while parent
			parents << parent
			parent = parents.last.parent
		end

		if parents.find {|par| par.data == coord}
			true
		else
			false
		end
	end
end