class Rank
	attr_reader :name

	def initialize(name)
		@name = name
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