require 'rails_helper'

describe "Beer" do
	before :each do
		FactoryGirl.create :user
		sign_in(username:"Pekka", password:"Foobar1")
	end

	it "is created when name is valid" do
		visit new_beer_path
		fill_in('beer_name', with:"Olut")

		expect{
			click_button "Create Beer"
		}.to change{Beer.count}.from(0).to(1)
	end

	it "is not created when name is valid and returns to creation page" do
		visit new_beer_path

		expect{
			click_button "Create Beer"
		}.to change{Beer.count}.by(0)
		expect(page).to have_content "Name can't be blank"
		expect(page).to have_content "New beer"
	end
end