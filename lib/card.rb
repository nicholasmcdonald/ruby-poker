class Card
	include Comparable

	attr_reader :rank, :suit

	def initialize(rank, suit)
		if (!rank.is_a? Rank) || (!suit.is_a? Suit) then raise ArgumentError end
		@rank = rank
		@suit = suit
	end

	def as_unicode
		base_unicode_value = 0x1F0A0
		base_unicode_value + rank.unicode_offset + suit.unicode_offset
	end

	def <=>(other)
		rank <=> other.rank
	end

	def ==(other)
		if !other.is_a? Card then return false end
		rank == other.rank && suit == other.suit
	end

	def has_rank?(rank)
		@rank == rank
	end

	def has_suit?(suit)
		@suit == suit
	end
end