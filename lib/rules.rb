module Rules
	def Rules.find_multiples_in(desired_matches, pile)
		pile.each do |card|
			matches = find_ranked_in card.rank, pile
			if matches.size >= desired_matches then return matches end
		end

		return Array.new
	end

	def Rules.find_connected_in(desired_streak, pile)
		pile.sort.reverse.each do |high_card|
			connected_cards = Array.new
			(0...desired_streak).each do |offset|
				check_rank = high_card.rank.offset_by -offset
				matches = Rules.find_ranked_in(check_rank, pile)
				break unless matches.size > 0
				connected_cards.concat matches
				return connected_cards if offset == desired_streak - 1
			end
		end

		return Array.new
	end

	def Rules.find_ranked_in(rank, pile)
		pile.reject{|card| !card.has_rank? rank}
	end

	def Rules.find_suited_in(suit, pile)
		pile.reject{|card| !card.has_suit? suit}
	end
end