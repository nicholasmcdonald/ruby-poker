class Card
	attr_reader :rank, :suit
	attr_accessor :is_in_play

	def initialize(rank, suit)
		@rank = rank
		@suit = suit
	end

	def as_unicode
		base_unicode_value = 0x1F0A0
		base_unicode_value + rank.unicode_offset + suit.unicode_offset
	end
end