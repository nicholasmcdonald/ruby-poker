class Suit
	attr_reader :name

	def initialize(name)
		@name = name
	end

	def self.is(search_suit)
		ALL.find { |suit| suit.name == search_suit }
	end

	def value
		ALL.find_index self
	end

	def unicode_offset
		16 * value
	end

	ALL = [
		self.new(:spades),
		self.new(:hearts),
		self.new(:diamonds),
		self.new(:clubs)
	]
end