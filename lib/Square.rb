require_relative 'Chess'

class Square < Chess
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

  def to_uni
    piece ? @piece.to_uni : "_"
  end

  def childrenify(parent_sq)
    @parent = parent_sq
    parent_sq.children << self
  end

  def collect_all_parents
    parents = []
		parent = @parent
		while parent
			parents << parent
			parent = parents.last.parent
		end
    parents
  end

	def has_parent?(coord)
		parents = collect_all_parents
		parents.find {|par| par.data == coord} ? true : false
	end
end