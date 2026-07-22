class Movie < ApplicationRecord
 def self.all_ratings
 ['G','PG','PG-13','R']
 end
 def self.with_ratings(ratings_list)
 ratings_list.present? ? where(rating: ratings_list) : all
 end
end
