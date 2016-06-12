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

	describe ".is" do
		context "given a rank name" do
			it "returns the Rank object with that name" do
				expect(Rank.is :five).to equal Rank::ALL[3]
			end
		end
	end

	describe "#value" do
		it "returns the Rank's index in ALL" do
			expect( (Rank.is :ace).value).to eq 12
		end
	end

	describe "<=>" do
		context "given two equal Ranks" do
			it "finds them to be equal" do
				expect(Rank.is(:eight)).to eq Rank.is :eight
			end
		end

		context "given a larger and smaller Rank" do
			it "finds the larger to be larger" do
				expect(Rank.is :seven).to be > (Rank.is :four)
			end
		end
	end

	describe "#unicode_offset" do
		context "when the rank is not ace" do
			it "returns the value plus two" do
				rank = Rank.is(:five)
				expect(rank.unicode_offset).to eq (rank.value + 2)
			end
		end

		context "when the rank is higher than jack" do
			it "returns the value plus three" do
				rank = Rank.is(:queen)
				expect(rank.unicode_offset).to eq (rank.value + 3)
			end
		end

		context "when the rank is ace" do
			it "returns 1" do
				expect(Rank.is(:ace).unicode_offset).to eq 1
			end
		end
	end

	describe "#offset_by" do
		context "given a king offset by -1" do
			it "returns the Rank queen" do
				expect(Rank.is(:king).offset_by(-1)).to eq Rank.is(:queen)
			end
		end

		context "given a two offset by 11" do
			it "returns the Rank king" do
				expect(Rank.is(:two).offset_by(11)).to eq Rank.is(:king)
			end
		end

		context "given a five offset by -4" do
			it "returns the Rank ace" do
				expect(Rank.is(:five).offset_by(-4)).to eq Rank.is(:ace)
			end
		end

		context "given a jack offset by 10" do
			it "returns nil" do
				expect(Rank.is(:jack).offset_by(10)).to be_nil
			end
		end

		context "given a king offset by 1" do
			it "returns the Rank ace" do
				expect(Rank.is(:king).offset_by(1)).to eq Rank.is(:ace)
			end
		end
	end
end