module Rules
	def self.find_multiples_in(desired_matches, pile)
		raise ArgumentError unless 
			desired_matches.is_a?(Integer) && pile.is_a?(Array)

		pile.collect{|card| find_ranked_in(card.rank, pile)}
			.find{|matches| matches.size >= desired_matches} || Array.new
	end

	def self.find_candidate_straights(length, pile)
		raise ArgumentError unless 
			length.is_a?(Integer) && pile.is_a?(Array) && (length > 1)

		package_duplicates(pile).each_cons(length)
			.select(&method(:connected?)) || Array.new
	end

	def self.package_duplicates(pile)
		pile.collect(&:rank).sort.reverse.uniq
			.collect{|rank| find_ranked_in(rank, pile)}
	end

	def self.connected?(candidate)
		candidate.drop(1).each_with_index.all? {
			|slot, i| slot[0].has_rank? candidate[i][0].rank.offset_by(-1) }
	end

	def self.find_ranked_in(rank, pile)
		pile.select{|card| card.has_rank? rank}
	end

	def self.find_suited_in(suit, pile)
		pile.select{|card| card.has_suit? suit}
	end
end