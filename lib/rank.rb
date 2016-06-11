class Rank
	ALL = Hash.new

	attr_reader :name, :value

	def initialize(name, value)
		@name = name
		@value = value
	end

	def self.setup
		ALL[:empty] = self.new("Empty", 0)
		ALL[:ace] = self.new("Ace", 1)
	end

	def self.allRanks
		
	end

	EMPTY = 0
end

module CardRanks
	EMPTY = 0
end

include CardRanks

Rank::setup

Rank::ALL.each do |symbol, name|
	puts symbol
end