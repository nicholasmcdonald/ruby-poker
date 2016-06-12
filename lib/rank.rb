class Rank
	include Comparable

	attr_reader :name

	def initialize(name)
		@name = name
	end

	def self.is(search_rank)
		ALL.find { |rank| rank.name == search_rank }
	end

	def value
		ALL.find_index self
	end

	def <=>(other)
		value <=> other.value
	end

	def unicode_offset
		if (self.name == :ace) then return 1
		elsif (self.value > Rank.is(:jack).value) then return value + 3
		else return value + 2 end
	end

	ALL = [
		self.new(:two),
		self.new(:three),
		self.new(:four),
		self.new(:five),
		self.new(:six),
		self.new(:seven),
		self.new(:eight),
		self.new(:nine),
		self.new(:ten),
		self.new(:jack),
		self.new(:queen),
		self.new(:king),
		self.new(:ace)
	]
end