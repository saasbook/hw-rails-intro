class Movie < ApplicationRecord
  ALL_RATINGS = %w[G PG PG-13 R NC-17]
  
  def self.all_ratings
    ALL_RATINGS
  end

  def self.with_ratings(ratings_list)
    if ratings_list.blank?
      all
    else
      where('UPPER(rating) IN (?)', ratings_list.map(&:upcase))
    end
  end
end
