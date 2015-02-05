require 'rails_helper'

describe "Rating" do
	let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
	let!(:beer1) { FactoryGirl.create :beer, name:"Iso 3", brewery:brewery }
	let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
	let!(:user) { FactoryGirl.create :user }

	before :each do
		sign_in(username:"Pekka", password:"Foobar1")
	end

	it "when given, is registered to the beer and user who is signed in" do
		visit new_rating_path
		select('Iso 3', from:'rating[beer_id]')
		fill_in('rating[score]', with:'15')

		expect{
			click_button "Create Rating"
		}.to change{Rating.count}.from(0).to(1)

		expect(user.ratings.count).to eq(1)
		expect(beer1.ratings.count).to eq(1)
		expect(beer1.average_rating).to eq(15.0)
	end

	describe "when there exists many" do
		before :each do
			user2 = FactoryGirl.create(:user, username:"Kalle")
			FactoryGirl.create(:rating, score:1, beer:beer1, user:user)
			FactoryGirl.create(:rating, score:2, beer:beer1, user:user2)
			FactoryGirl.create(:rating, score:3, beer:beer2, user:user)
		end

		it "ratings are listed on the page" do
			visit ratings_path
			expect(page).to have_content "Number of ratings: 3"
			expect(page).to have_content "#{beer1.name} 1"
			expect(page).to have_content "#{beer1.name} 2"	
			expect(page).to have_content "#{beer2.name} 3"
		end

		it "shows only user's own on user's page" do
			visit user_path(user)
			expect(page).to have_content "Has made 2 ratings"
			expect(page).to have_content "#{beer1.name} 1"
			expect(page).to have_content "#{beer2.name} 3"
			expect(page).not_to have_content "#{beer1.name} 2"
		end

		it "are destroyed when user deletes them" do
			visit user_path(user)
			expect{
				page.first(:link, "Delete").click
			}.to change{Rating.count}.by(-1)
		end
	end
end