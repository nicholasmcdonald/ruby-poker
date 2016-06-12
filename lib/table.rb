class Table
	attr_reader :community_cards, :hole_cards
	attr_accessor :number_of_opponents

	def initialize
		@community_cards = Array.new
		@hole_cards = Array.new
	end

	def add_community_card_at(card, index)
		if (!index.between?(0,4)) || (!card.is_a? Card)
			raise ArgumentError
		else 
			@community_cards[index] = card
		end
	end

	def add_hole_card_at(card, index)
		if (!index.between?(0,1)) || (!card.is_a? Card)
			raise ArgumentError
		else 
			 @hole_cards[index] = card 
		end
	end
end