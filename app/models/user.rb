class User < ActiveRecord::Base
	include RatingAverage

	has_secure_password

	validates :username, uniqueness: true, 
						 length: { minimum: 3, maximum: 15 }

	validates :password, length: { minimum: 4 },
						 format: { with: /.*(\d.*[A-Z]|[A-Z].*\d).*/, message: "needs at least one uppercase letter and a number" }

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :memberships, dependent: :destroy

	has_many :confirmed_memberships, ->{ where confirmed:true }, class_name: 'Membership'
	has_many :applications, ->{ where confirmed:[nil, false] }, class_name: 'Membership'

	has_many :beer_clubs, through: :confirmed_memberships
	has_many :outstanding_club_applications, through: :applications, source: :beer_club

	def favorite_beer
		return nil if ratings.empty?
		ratings.order(score: :desc).limit(1).first.beer
	end

	def favorite_style
		return nil if ratings.empty?
		beers.group(:style).order("average_score desc").average(:score).keys[0]
	end

	def favorite_brewery
		return nil if ratings.empty?
		beers.group(:brewery).order("average_score desc").average(:score).keys[0]
	end

	def self.top(n)
		sorted_by_rating_in_desc_order = self.all.sort_by{ |b| -(b.ratings.count||0) }
		sorted_by_rating_in_desc_order[0..n-1]
	end
end