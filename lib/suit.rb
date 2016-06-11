class Suit
	attr_reader :name

	def initialize(name)
		@name = name
	end

	def self.get(search_suit)
		ALL.find { |suit| suit.name == search_suit }
	end

	ALL = [
		self.new(:spades),
		self.new(:hearts),
		self.new(:diamonds),
		self.new(:clubs)
	]
end