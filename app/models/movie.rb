class Movie < ApplicationRecord
  def self.all_ratings
    ['G', 'PG', 'PG-13', 'R']
  end

  def self.with_ratings(ratings)
    where(rating: ratings)
  end
end
