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
	end
end