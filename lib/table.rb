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
			remove_duplicate(card)
			@community_cards[index] = card
		end
	end

	def add_hole_card_at(card, index)
		if (!index.between?(0,1)) || (!card.is_a? Card)
			raise ArgumentError
		else 
			remove_duplicate(card)
			 @hole_cards[index] = card 
		end
	end

	def cards_in_play
		community_cards.concat(hole_cards).reject{|card| card.nil?}
	end

	def undealt_cards
		Table.generate_deck.reject{|card| cards_in_play.include? card}
	end

	def self.generate_deck
		Rank::ALL.product(Suit::ALL).collect{|rank, suit| Card.new(rank, suit)}
	end

	def remove_duplicate(card)
		if community_cards.include? card
			community_cards.delete_at community_cards.index(card)
		elsif hole_cards.include? card
			hole_cards.delete_at hole_cards.index(card)
		end	
	end
end