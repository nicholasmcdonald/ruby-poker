require 'rules'

describe Rules do
	describe ".find_ranked_in" do
		context "given an empty pile" do
			it "finds no matches" do
				table = Table.new
				rank = Rank.is(:five)
				expect(Rules.find_ranked_in(rank, table.cards_in_play).size)
					.to eq 0
			end
		end

		context "given any rank and a fresh deck" do
			it "returns four cards of that rank" do
				table = Table.new
				rank = Rank.is :jack
				matches = Rules.find_ranked_in(rank, table.undealt_cards)
				expect(matches.size).to eq 4
				expect(matches[0].has_rank? rank).to be true
			end
		end

		context "given a pile missing two fives" do
			it "finds the other two" do
				table = Table.new
				rank = Rank.is :five
				card = Card.new(rank, Suit.is(:clubs))
				table.add_community_card_at(card, 0)
				card = Card.new(rank, Suit.is(:diamonds))
				table.add_hole_card_at(card, 0)
				matches = Rules.find_ranked_in(rank, table.cards_in_play)
				expect(matches.size).to eq 2
				expect(matches[0].has_rank? rank).to be true
			end
		end
	end

	describe ".find_multiples_in" do
		context "given an empty pile and 1 desired match" do
			it "finds no matches" do
				table = Table.new
				expect(Rules
					.find_multiples_in(1, table.cards_in_play).size)
					.to eq 0
			end
		end

		context "given a pile with two kings and 3 desired matches" do
			it "finds no triplet" do
				table = Table.new
				rank = Rank.is :king
				card = Card.new(rank, Suit.is(:clubs))
				table.add_community_card_at(card, 0)
				card = Card.new(rank, Suit.is(:diamonds))
				table.add_hole_card_at(card, 0)
				expect(Rules.find_multiples_in(3, table.cards_in_play))
					.to be_empty
			end
		end

		context "given a pile with two kings and 2 desired matches" do
			it "finds the pair" do
				table = Table.new
				rank = Rank.is :king
				card = Card.new(rank, Suit.is(:clubs))
				table.add_community_card_at(card, 0)
				card = Card.new(rank, Suit.is(:diamonds))
				table.add_hole_card_at(card, 0)
				matches = Rules.find_multiples_in(2, table.cards_in_play)
				expect(matches.size).to eq 2
				expect(matches[0].has_rank? rank).to be true
			end
		end
	end

	describe ".find_suited_in" do
		context "given a fresh deck and spades argument" do
			it "finds all of the spades" do
				suit = Suit.is :spades
				flush = Rules.find_suited_in(suit, Table.new.undealt_cards)
				expect(flush.size).to eq 13
				expect(flush[0].has_suit? Suit.is(:spades)).to be true
			end
		end
	end

	# describe ".find_connected_in" do
	# 	context "given a fresh deck and 0 desired streak" do
	# 		it "returns an empty array" do
	# 			expect(Rules.find_connected_in(0, Table.new.undealt_cards).size)
	# 				.to eq 0
	# 		end
	# 	end

	# 	context "given a fresh deck and 13 desired streak" do
	# 		it "finds all the cards" do
	# 			expect(Rules.find_connected_in(13, Table.new.undealt_cards).size)
	# 				.to eq 52
	# 		end
	# 	end

	# 	context "given a table with five cards in a row, ace high" do
	# 		it "returns those five cards" do
	# 			table = Table.new
	# 			card = Card.new(Rank.is(:ace), Suit.is(:clubs))
	# 			table.add_community_card_at(card, 4)
	# 			card = Card.new(Rank.is(:king), Suit.is(:hearts))
	# 			table.add_community_card_at(card, 1)
	# 			card = Card.new(Rank.is(:queen), Suit.is(:diamonds))
	# 			table.add_community_card_at(card, 3)
	# 			card = Card.new(Rank.is(:jack), Suit.is(:clubs))
	# 			table.add_community_card_at(card, 0)
	# 			card = Card.new(Rank.is(:ten), Suit.is(:spades))
	# 			table.add_hole_card_at(card, 1)
	# 			straight = Rules.find_connected_in(5, table.cards_in_play)
	# 			expect(straight.size).to eq 5
	# 			expect(straight[0].rank).to eq Rank.is(:ace) 
	# 			expect(straight[4].rank).to eq Rank.is(:ten) 
	# 		end
	# 	end

	# 	context "given a table with five cards in a row, including duplicates" do
	# 		it "returns the five different ranks and each duplicate" do
	# 			table = Table.new
	# 			card = Card.new(Rank.is(:seven), Suit.is(:clubs))
	# 			table.add_community_card_at(card, 4)
	# 			card = Card.new(Rank.is(:six), Suit.is(:hearts))
	# 			table.add_community_card_at(card, 1)
	# 			card = Card.new(Rank.is(:six), Suit.is(:diamonds))
	# 			table.add_community_card_at(card, 3)
	# 			card = Card.new(Rank.is(:five), Suit.is(:clubs))
	# 			table.add_community_card_at(card, 0)
	# 			card = Card.new(Rank.is(:four), Suit.is(:spades))
	# 			table.add_hole_card_at(card, 1)
	# 			card = Card.new(Rank.is(:four), Suit.is(:clubs))
	# 			table.add_hole_card_at(card, 0)
	# 			card = Card.new(Rank.is(:three), Suit.is(:diamonds))
	# 			table.add_community_card_at(card, 2)
	# 			straight = Rules.find_connected_in(5, table.cards_in_play)
	# 			expect(straight.size).to eq 7
	# 			expect(straight[0].rank).to eq Rank.is(:seven) 
	# 			expect(straight[6].rank).to eq Rank.is(:three) 				
	# 		end
	# 	end

	# 	context "given a table with five cards in a row, ace low" do
	# 		it "returns those five cards" do
	# 			table = Table.new
	# 			card = Card.new(Rank.is(:five), Suit.is(:clubs))
	# 			table.add_community_card_at(card, 4)
	# 			card = Card.new(Rank.is(:four), Suit.is(:hearts))
	# 			table.add_community_card_at(card, 1)
	# 			card = Card.new(Rank.is(:three), Suit.is(:diamonds))
	# 			table.add_community_card_at(card, 3)
	# 			card = Card.new(Rank.is(:two), Suit.is(:clubs))
	# 			table.add_community_card_at(card, 0)
	# 			card = Card.new(Rank.is(:ace), Suit.is(:spades))
	# 			table.add_hole_card_at(card, 1)
	# 			straight = Rules.find_connected_in(5, table.cards_in_play)
	# 			expect(straight.size).to eq 5
	# 			expect(straight[0].rank).to eq Rank.is(:five) 
	# 			expect(straight[4].rank).to eq Rank.is(:ace) 
	# 		end
	# 	end

	# 	context "given a table with 4-3-2-A-K" do
	# 		it "return nothing, as this is not a straight" do
	# 			table = Table.new
	# 			card = Card.new(Rank.is(:four), Suit.is(:hearts))
	# 			table.add_community_card_at(card, 1)
	# 			card = Card.new(Rank.is(:three), Suit.is(:diamonds))
	# 			table.add_community_card_at(card, 3)
	# 			card = Card.new(Rank.is(:two), Suit.is(:clubs))
	# 			table.add_community_card_at(card, 0)
	# 			card = Card.new(Rank.is(:ace), Suit.is(:spades))
	# 			table.add_hole_card_at(card, 1)
	# 			card = Card.new(Rank.is(:king), Suit.is(:clubs))
	# 			table.add_community_card_at(card, 4)
	# 			straight = Rules.find_connected_in(5, table.cards_in_play)
	# 			expect(straight.size).to eq 0
	# 		end
	# 	end
	# end

	describe ".package_duplicates" do
		context "given seven cards 2-5-7-5-J-A-A" do
			it "sorts them into arrays with pairs appearing together" do
				table = Table.new
				card = Card.new(Rank.is(:two), Suit.is(:hearts))
				table.add_community_card_at(card, 0)
				card = Card.new(Rank.is(:five), Suit.is(:diamonds))
				table.add_community_card_at(card, 1)
				card = Card.new(Rank.is(:seven), Suit.is(:clubs))
				table.add_community_card_at(card, 2)
				card = Card.new(Rank.is(:five), Suit.is(:spades))
				table.add_hole_card_at(card, 0)
				card = Card.new(Rank.is(:jack), Suit.is(:clubs))
				table.add_community_card_at(card, 3)
				card = Card.new(Rank.is(:ace), Suit.is(:spades))
				table.add_hole_card_at(card, 1)
				card = Card.new(Rank.is(:ace), Suit.is(:clubs))
				table.add_community_card_at(card, 4)
				result = Rules.package_duplicates(table.cards_in_play)
				expect(result.size).to eq 5
				expect(result[0].size).to eq 2
				expect(result[0][1].rank).to eq Rank.is(:ace)
				expect(result[3].size).to eq 2
				expect(result[3][1].rank).to eq Rank.is(:five)
				expect(result[1].size).to eq 1
			end
		end
	end

	describe ".find_candidate_straights" do
		context "given a request for zero-length straights" do
			it "raises an exception" do
				expect{Rules.find_candidate_straights(0, Table.new.undealt_cards)}
					.to raise_error ArgumentError
			end
		end

		context "given an invalid pile" do
			it "raises an exception" do
				expect{Rules.find_candidate_straights(5, nil)}
					.to raise_error ArgumentError
			end
		end

		context "given seven cards packaged by duplicates" do
			it "collects all possible straights" do
				table = Table.new
				card = Card.new(Rank.is(:king), Suit.is(:hearts))
				table.add_community_card_at(card, 0)
				card = Card.new(Rank.is(:queen), Suit.is(:diamonds))
				table.add_community_card_at(card, 1)
				card = Card.new(Rank.is(:nine), Suit.is(:clubs))
				table.add_community_card_at(card, 2)
				card = Card.new(Rank.is(:ten), Suit.is(:spades))
				table.add_hole_card_at(card, 0)
				card = Card.new(Rank.is(:jack), Suit.is(:clubs))
				table.add_community_card_at(card, 3)
				card = Card.new(Rank.is(:ace), Suit.is(:spades))
				table.add_hole_card_at(card, 1)
				card = Card.new(Rank.is(:ace), Suit.is(:clubs))
				table.add_community_card_at(card, 4)
				results = Rules.find_candidate_straights(5, table.cards_in_play)
				expect(results.size).to eq 2
				expect(results[0].size).to eq 5
				expect(results[0][0][0].rank).to eq Rank.is(:ace)
				expect(results[1][0][0].rank).to eq Rank.is(:king)
			end
		end
	end
end