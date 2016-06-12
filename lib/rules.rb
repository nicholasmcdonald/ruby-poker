module Rules
	def self.find_multiples_in(desired_matches, pile)
		pile.each do |card|
			matches = find_ranked_in(card.rank, pile)
			return matches if matches.size >= desired_matches
		end

		return Array.new
	end

	def self.find_connected_in(length, pile)
		pile.sort.reverse.each do |high_card|
			connected_cards = Array.new
			(0...length).each do |offset|
				check_rank = high_card.rank.offset_by -offset
				matches = find_ranked_in(check_rank, pile)
				break unless matches.size > 0
				connected_cards.concat matches
				return connected_cards if offset == length - 1
			end
		end

		return Array.new
	end

	def self.find_ranked_in(rank, pile)
		pile.select{|card| card.has_rank? rank}
	end

	def self.find_suited_in(suit, pile)
		pile.select{|card| card.has_suit? suit}
	end
end