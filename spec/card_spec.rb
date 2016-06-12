require 'card'
require 'rank'
require 'suit'

describe Card do
	describe 'attributes' do
		it "can be assigned a rank" do
			card = Card.new(Rank.is(:ace), Suit.is(:spades))
			expect(card.rank.name).to eq Rank::ALL[12].name
		end

		it "can be assigned a suit" do
			card = Card.new(Rank.is(:ace), Suit.is(:spades))
			expect(card.suit.name).to eq Suit::ALL[0].name
		end
	end

	describe "#as_unicode" do
		context "when ace of spades" do
			it "converts to 0x1F0A1" do
				card = Card.new(Rank.is(:ace), Suit.is(:spades))
				expect(card.as_unicode).to eq 0x1F0A1
			end
		end

		context "when king of clubs" do
			it "converts to 0x1F0DD" do
				card = Card.new(Rank.is(:king), Suit.is(:clubs))
				expect(card.as_unicode).to eq 0x1F0DE
			end
		end
	end

	describe ".new" do
		context "given an invalid rank or suit" do
			it "raises an ArgumentError" do
				expect { Card.new(0, Suit.is(:clubs)) }
					.to raise_error(ArgumentError)
				expect { Card.new(Rank.is(:nine), "a") }
					.to raise_error(ArgumentError)
			end
		end
	end
end
