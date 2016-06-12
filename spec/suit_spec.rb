require 'suit'

describe Suit do
	describe "#name" do
		it "returns the suit name" do
			expect(Suit.new(:test).name).to eq :test
		end
	end

	describe "ALL" do
		it "starts with spades" do
			expect(Suit::ALL[0].name).to eq :spades
		end

		it "ends with clubs" do
			expect(Suit::ALL[Suit::ALL.count - 1].name).to eq :clubs
		end
	end

	describe ".get" do
		context "given a suit name" do
			it "returns the matching Suit object" do
				expect(Suit.is(:diamonds)).to equal Suit::ALL[2]
			end
		end
	end

	describe "#unicode_offset" do
		it "returns 16 times the value" do
			expect(Suit.is(:clubs).unicode_offset).to eq 48
		end
	end
end