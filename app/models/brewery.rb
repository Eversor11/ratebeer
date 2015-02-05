class Brewery < ActiveRecord::Base
	include RatingAverage

	validates :name, presence: true, allow_blank: false
	validates :year, numericality: { greater_than_or_equal_to: 1042,
									 only_integer: true}
	validate :year_cannot_be_in_the_future

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def year_cannot_be_in_the_future
		if year > Date.today.year
			errors.add(:year, "can't be in the future")
		end
	end

	def to_s
		"#{name}"
	end
end