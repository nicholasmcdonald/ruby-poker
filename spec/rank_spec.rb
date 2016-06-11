require 'rank'

describe Rank do
	describe ".name" do
		it "returns the Rank name" do
			expect(Rank.new(:test).name).to eq :test
		end
	end

	describe "ALL" do
		it "starts at :two" do
			expect(Rank::ALL[0].name).to eq :two
		end

		it "ends at :ace" do
			expect(Rank::ALL[Rank::ALL.count - 1].name).to eq :ace
		end
	end
end