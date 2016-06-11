require 'rank'

describe Rank do
	describe "#name" do
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

	describe ".get" do
		context "given a rank name" do
			it "returns the Rank object with that name" do
				expect(Rank.get :five).to equal Rank::ALL[3]
			end
		end
	end

	describe "#value" do
		it "returns the Rank's index in ALL" do
			expect( (Rank.get :ace).value).to eq 12
		end
	end

	describe "<=>" do
		context "given two equal Ranks" do
			it "finds them to be equal" do
				expect(Rank.get(:eight)).to eq Rank.get :eight
			end
		end

		context "given a larger and smaller Rank" do
			it "finds the larger to be larger" do
				expect(Rank.get :seven).to be > (Rank.get :four)
			end
		end
	end
end