module Rules
	def Rules.find_multiples_in(desired_matches, pile)
		pile.each do |card|
			matches = all_ranked card.rank, pile
			if matches.size >= desired_matches then return matches end
		end

		return Array.new
	end

	def Rules.all_ranked(rank, pile)
		pile.reject{|card| !card.has_rank? rank}
	end

	def Rules.find_flush_in(pile)
		Suit::ALL.each do |suit|
			matches = pile.reject{|card| !card.has_suit? suit}
			if matches.size >= 5 then return matches end
		end

		return Array.new
	end
end