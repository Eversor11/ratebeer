require 'rails_helper'

describe Beer do
	it "is saved when it has a name and a style" do
		BeerClub
		BeerClubsController
		MembershipsController
		StylesController

		beer = Beer.create name:"Kalja", style:FactoryGirl.create(:style)

		expect(beer).to be_valid
		expect(Beer.count).to eq(1)
	end

	describe "is not saved when" do
		it "name doesn't exist" do
			beer = Beer.create style:FactoryGirl.create(:style)

			expect(beer).not_to be_valid
			expect(Beer.count).to eq(0)
		end

		it "style doesn't exist" do
			beer = Beer.create name:"Kalja"

			expect(beer).not_to be_valid
			expect(Beer.count).to eq(0)
		end
	end
end