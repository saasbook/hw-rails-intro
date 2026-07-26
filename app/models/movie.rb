class Movie < ApplicationRecord
  SORTABLE_COLUMNS = %w[title release_date].freeze

  def self.all_ratings
    %w[G PG PG-13 R]
  end

  def self.with_ratings(ratings_list)
    return all unless ratings_list.present?

    where("LOWER(rating) IN (?)", ratings_list.map(&:downcase))
  end

  def self.sorted_by(column)
    return all unless SORTABLE_COLUMNS.include?(column)

    order(column => :asc)
  end
end