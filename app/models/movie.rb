class Movie < ApplicationRecord
  def self.all_ratings
    ['G','PG','PG-13','R']
  end
  def self.with_ratings(ratings)
    if ratings.present?
      where('LOWER(rating) IN (?)', ratings.map(&:downcase))
    else
      all
    end
  end
end
