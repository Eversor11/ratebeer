class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :beer_club

	validate :user, uniqueness: { scope: :beer_club }
end
