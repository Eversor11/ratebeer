require 'rails_helper'

describe User do
	it "has the username set correctly" do
		user = User.new username:"Pekka"

		expect(user.username).to eq("Pekka")
	end

	describe "is not saved when password" do
		it "doesn't exist" do
			user = User.create username:"Pekka"

			expect(user).not_to be_valid
			expect(User.count).to eq(0)
		end

		it "is too short" do
			user = User.create username:"Pekka", password:"A1", password_confirmation:"A1"
			
			expect(user).not_to be_valid
			expect(User.count).to eq(0)
		end

		it "consists of only letters" do
			user = User.create username:"Pekka", password:"Secret", password_confirmation:"Secret"

			expect(user).not_to be_valid
			expect(User.count).to eq(0)
		end
	end

	describe "with a proper password" do
		let(:user){ FactoryGirl.create(:user) }

		it "is saved" do
			expect(user).to be_valid
			expect(User.count).to eq(1)
		end

		it "and with two ratings, has the correct average rating" do
			user.ratings << FactoryGirl.create(:rating)
			user.ratings << FactoryGirl.create(:rating2)

			expect(user.ratings.count).to eq(2)
			expect(user.average_rating).to eq(15.0)
		end
	end

	describe "favorite beer" do
		let(:user){ FactoryGirl.create(:user) }

		it "has method for determining one" do
			expect(user).to respond_to(:favorite_beer)
		end

		it "without ratings doesn't have one" do
			expect(user.favorite_beer).to eq(nil)
		end

		it "is the only rated if only one rating" do
			create_beers_with_ratings(10, user)
			expect(user.favorite_beer).to eq(Beer.first)
		end

		it "is the one with highest rating if several rated" do
			create_beers_with_ratings(10, 20, 15, 7, 9, user)
			create_beers_with_ratings(25, user)

			expect(user.favorite_beer).to eq(Beer.last)
		end
	end

	describe "favorite style" do
		let(:user){ FactoryGirl.create(:user) }

		it "has method for determining one" do
			expect(user).to respond_to(:favorite_style)
		end

		it "without ratings doesn't have one" do
			expect(user.favorite_beer).to eq(nil)
		end

		it "is the only rated if only one rating" do
			beer = create_beers_with_ratings_and_style(10, FactoryGirl.create(:style, name:"Iso"), user)

			expect(user.favorite_style.name).to eq("Iso")
		end

		it "is the one with highest rating if several rated" do
			create_beers_with_ratings_and_style(10, 20, 15, 7, 9, FactoryGirl.create(:style, name:"Iso"), user)
			create_beers_with_ratings_and_style(19, 20, 22, FactoryGirl.create(:style, name:"Pedo"), user)
			create_beers_with_ratings_and_style(25, 1, FactoryGirl.create(:style, name:"Karhu"), user)
			create_beers_with_ratings_and_style(20, FactoryGirl.create(:style, name:"Meme"), user)

			expect(user.favorite_style.name).to eq("Pedo")
		end
	end

	describe "favorite brewery" do
		let(:user){ FactoryGirl.create(:user) }

		it "has method for determining one" do
			expect(user).to respond_to(:favorite_brewery)
		end

		it "without ratings doesn't have one" do
			expect(user.favorite_brewery).to eq(nil)
		end

		it "is the only rated if only one rating" do
			brewery = FactoryGirl.create(:brewery, name:"Kontula")
			create_beers_with_ratings_and_brewery(10, brewery, user)
		
			expect(user.favorite_brewery).to eq(brewery)
		end

		it "is the one with highest rating if several rated" do
			brewery = FactoryGirl.create(:brewery, name:"Kontula")
			create_beers_with_ratings_and_brewery(10, 20, 15, 7, 9, FactoryGirl.create(:brewery), user)
			create_beers_with_ratings_and_brewery(19, 20, 22, brewery, user)
			create_beers_with_ratings_and_brewery(25, 1, FactoryGirl.create(:brewery), user)
			create_beers_with_ratings_and_brewery(20, FactoryGirl.create(:brewery), user)
		
			expect(user.favorite_brewery).to eq(brewery)
		end
	end
end

def create_beer_with_rating(score, style, brewery, user)
	beer = FactoryGirl.create(:beer, style:style, brewery:brewery)
	FactoryGirl.create(:rating, score:score, beer:beer, user:user)
	beer
end

def create_beers_with_ratings(*scores, user)
	scores.each do |score|
		create_beer_with_rating(score, FactoryGirl.create(:style), FactoryGirl.create(:brewery), user)
	end
end

def create_beers_with_ratings_and_style(*scores, style, user)
	scores.each do |score|
		create_beer_with_rating(score, style, FactoryGirl.create(:brewery), user)
	end
end

def create_beers_with_ratings_and_brewery(*scores, brewery, user)
	scores.each do |score|
		create_beer_with_rating(score, FactoryGirl.create(:style), brewery, user)
	end
end