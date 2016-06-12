require 'rules'

describe Rules do
	describe ".all_ranked" do
		context "given an empty pile" do
			it "finds no matches" do
				table = Table.new
				rank = Rank.is(:five)
				expect(Rules.all_ranked(rank, table.cards_in_play).size)
					.to eq 0
			end
		end

		context "given any rank and a fresh deck" do
			it "returns four cards of that rank" do
				table = Table.new
				rank = Rank.is :jack
				matches = Rules.all_ranked(rank, table.undealt_cards)
				expect(matches.size).to eq 4
				expect(matches[0].has_rank? rank).to be true
			end
		end

		context "given a pile missing two fives" do
			it "finds the other two fives" do
				table = Table.new
				rank = Rank.is :five
				card = Card.new(rank, Suit.is(:clubs))
				table.add_community_card_at(card, 0)
				card = Card.new(rank, Suit.is(:diamonds))
				table.add_hole_card_at(card, 0)
				matches = Rules.all_ranked(rank, table.cards_in_play)
				expect(matches.size).to eq 2
				expect(matches[0].has_rank? rank).to be true
			end
		end
	end

	describe ".find_multiples" do
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

	describe ".find_flush_in" do
		context "given a fresh deck" do
			it "finds all of the spades" do
				flush = Rules.find_flush_in(Table.new.undealt_cards)
				expect(flush.size).to eq 13
				expect(flush[0].has_suit? Suit.is(:spades)).to be true
			end
		end
	end
end



