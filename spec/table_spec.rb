require 'table'
require 'card'
require 'rank'
require 'suit'

describe Table do
	describe "attributes" do
		table = Table.new
		it "can set community cards" do
			card = Card.new(Rank.is(:five), Suit.is(:hearts))
			table.add_community_card_at(card, 4)
			expect(table.community_cards[4]).to equal card
		end
	
		it "can set hole cards" do
			card = Card.new(Rank.is(:three), Suit.is(:diamonds))
			table.add_hole_card_at(card, 1)
			expect(table.hole_cards[1]).to equal card
		end

		it "can set number of opponents" do
			table.number_of_opponents= 5
			expect(table.number_of_opponents).to eq 5
		end
	end

	describe "add to community or hole cards" do
		context "given an invalid index or card" do
			it "raises an ArgumentError" do
				table = Table.new
				card = Card.new(Rank.is(:three), Suit.is(:spades))
				expect {table.add_community_card_at(card, 7)}
					.to raise_error(ArgumentError)
				expect {table.add_community_card_at(0, 3)}
					.to raise_error(ArgumentError)
				expect {table.add_hole_card_at(card, 7)}
					.to raise_error(ArgumentError)
				expect {table.add_hole_card_at(0, 1)}
					.to raise_error(ArgumentError)
			end
		end

		context "given a duplicate card" do
			it "removes the original and adds the new card" do
				table = Table.new
				card = Card.new(Rank.is(:five), Suit.is(:hearts))
				table.add_community_card_at(card, 4)
				expect { table.add_hole_card_at(card, 0) }
					.to change { table.community_cards[4] }
					.from(card)
					.to(nil)
			end
		end
	end

	describe "#cards_in_play" do
		context "when all card slots are filled" do
			it "returns an array of seven cards" do
				table = Table.new
				card = Card.new(Rank.is(:five), Suit.is(:clubs))
				table.add_community_card_at(card, 0)
				card = Card.new(Rank.is(:six), Suit.is(:hearts))
				table.add_community_card_at(card, 1)
				card = Card.new(Rank.is(:nine), Suit.is(:clubs))
				table.add_community_card_at(card, 2)
				card = Card.new(Rank.is(:four), Suit.is(:diamonds))
				table.add_community_card_at(card, 3)
				card = Card.new(Rank.is(:king), Suit.is(:clubs))
				table.add_community_card_at(card, 4)
				card = Card.new(Rank.is(:queen), Suit.is(:hearts))
				table.add_hole_card_at(card, 0)
				card = Card.new(Rank.is(:five), Suit.is(:spades))
				table.add_hole_card_at(card, 1)
				expect(table.cards_in_play.size).to eq 7
			end
		end

		context "when some card slots are empty" do
			it "returns an array not containing nils" do
				table = Table.new
				card = Card.new(Rank.is(:five), Suit.is(:clubs))
				table.add_community_card_at(card, 0)
				card = Card.new(Rank.is(:six), Suit.is(:hearts))
				table.add_community_card_at(card, 2)
				card = Card.new(Rank.is(:nine), Suit.is(:clubs))
				table.add_community_card_at(card, 4)
				card = Card.new(Rank.is(:five), Suit.is(:spades))
				table.add_hole_card_at(card, 1)
				expect(table.cards_in_play.size).to eq 4
			end
		end
	end

	describe ".generate_deck" do
		it "begins with two of spades" do
			card = Card.new(Rank.is(:two), Suit.is(:spades))
			expect(Table.generate_deck[0]).to eq card
		end

		it "ends with ace of Clubs" do
			card = Card.new(Rank.is(:ace), Suit.is(:clubs))
			expect(Table.generate_deck[51]).to eq card
		end
	end

	describe "#undealt_cards" do
		context "given a new table" do
			it "returns all 52 cards" do
				expect(Table.new.undealt_cards.size).to eq 52
			end
		end

		context "given a table with 3 cards in play" do
			it "returns the other 49 cards" do
				table = Table.new
				card1 = Card.new(Rank.is(:three), Suit.is(:spades))
				table.add_community_card_at(card1, 1)
				card2 = Card.new(Rank.is(:three), Suit.is(:clubs))
				table.add_hole_card_at(card2, 0)
				card3 = Card.new(Rank.is(:three), Suit.is(:diamonds))
				table.add_community_card_at(card3, 4)
				expect(table.undealt_cards.size).to eq 49
				expect(table.undealt_cards).not_to include card1
				expect(table.undealt_cards).not_to include card2
				expect(table.undealt_cards).not_to include card3
			end
		end
	end
end