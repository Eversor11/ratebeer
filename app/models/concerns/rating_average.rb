module RatingAverage
	extend ActiveSupport::Concern

	def average_rating
		ratings.inject(0) do |sum, rating| 
			sum + rating.score 
		end.to_f / ratings.count 
	end
end