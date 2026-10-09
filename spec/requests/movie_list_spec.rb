require "rails_helper"

# The features this assignment adds to the movie list. These rely only on what
# the instructions require -- the form field names, the element ids and the
# hilite class -- and follow the column header links rather than assuming how
# they are built, so they pass for any working solution.
RSpec.describe "Movie list", type: :request do
  before do
    [["Aladdin", "G", "1992-11-25"], ["The Terminator", "R", "1984-10-26"],
     ["Chocolat", "PG-13", "2001-01-05"], ["The Incredibles", "PG", "2004-11-05"],
     ["Raiders of the Lost Ark", "PG", "1981-06-12"]].each do |title, rating, date|
      Movie.create!(title: title, rating: rating, release_date: date)
    end
  end

  # the latest response, parsed afresh (a let would keep showing the first one)
  def page
    Nokogiri::HTML(response.body)
  end

  def column(name)
    index = { title: 0, rating: 1, release_date: 2 }.fetch(name)
    page.css("table#movies tbody tr").map { |row| row.css("th, td")[index].text.strip }
  end

  def release_dates
    column(:release_date).map { |date| Date.parse(date) }
  end

  def checked_ratings
    page.css("#ratings_form input[type=checkbox][checked]").map { |box| box["id"].delete_prefix("ratings_") }
  end

  def follow_header(name)
    link = page.at_css("a##{name}_header") || page.at_css("##{name}_header a")
    expect(link).not_to be_nil, "Expected a link with id '#{name}_header' in the column header"
    get link["href"]
  end

  def header_classes(name)
    cell = page.css("table#movies thead th").find { |th| th["id"] == "#{name}_header" || th.at_css("##{name}_header") }
    [cell&.[]("class"), cell&.at_css("a")&.[]("class")].compact.join(" ")
  end

  describe "filtering by rating" do
    it "has a ratings form with a checkbox for every rating and a submit button" do
      get movies_path
      expect(page.at_css("form#ratings_form")).not_to be_nil
      expect(page.at_css("#ratings_submit")).not_to be_nil
      %w[G PG PG-13 R].each { |rating| expect(page.at_css("#ratings_#{rating}")).not_to be_nil }
    end

    it "shows every movie, with every box checked, when nothing is chosen" do
      get movies_path
      expect(column(:title).size).to eq 5
      expect(checked_ratings).to match_array %w[G PG PG-13 R]
    end

    it "shows only the movies with the checked ratings, and keeps those boxes checked" do
      get movies_path, params: { ratings: { "PG" => "1", "R" => "1" } }
      expect(column(:rating)).to match_array %w[R PG PG]
      expect(checked_ratings).to match_array %w[PG R]
    end
  end

  describe "sorting" do
    it "sorts by title from the Movie Title header and highlights it" do
      get movies_path
      follow_header(:title)
      expect(column(:title)).to eq column(:title).sort
      expect(header_classes(:title)).to match(/\bhilite\b/)
    end

    it "sorts by release date from the Release Date header and highlights it" do
      get movies_path
      follow_header(:release_date)
      expect(release_dates).to eq release_dates.sort
      expect(header_classes(:release_date)).to match(/\bhilite\b/)
    end

    it "keeps the rating filter when sorting" do
      get movies_path, params: { ratings: { "PG" => "1" } }
      follow_header(:title)
      expect(column(:title)).to eq ["Raiders of the Lost Ark", "The Incredibles"]
    end
  end

  describe "remembering the settings" do
    it "restores the last sort and filter when the list is visited again" do
      get movies_path, params: { ratings: { "PG" => "1", "G" => "1" } }
      follow_header(:release_date)
      get movies_path
      expect(column(:title)).to eq ["Raiders of the Lost Ark", "Aladdin", "The Incredibles"]
      expect(checked_ratings).to match_array %w[G PG]
    end
  end
end
