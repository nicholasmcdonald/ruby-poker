class Card
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
end