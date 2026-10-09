require "rails_helper"

RSpec.describe "Movies", type: :request do
  let!(:movie) do
    Movie.create!(title: "Star Wars", rating: "PG", description: "A long time ago...",
                  release_date: "1977-05-25")
  end
  let(:movie_attributes) do
    { title: "Aladdin", rating: "G", description: "A whole new world", release_date: "1992-11-25" }
  end

  describe "GET /movies" do
    it "renders the list of movies" do
      get movies_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Star Wars")
    end
  end

  describe "GET /movies/new" do
    it "renders the new movie form" do
      get new_movie_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /movies" do
    it "creates a movie and redirects to it" do
      expect {
        post movies_path, params: { movie: movie_attributes }
      }.to change(Movie, :count).by(1)
      expect(response).to redirect_to(movie_path(Movie.last))
    end
  end

  describe "GET /movies/:id" do
    it "shows the movie" do
      get movie_path(movie)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /movies/:id/edit" do
    it "renders the edit form" do
      get edit_movie_path(movie)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /movies/:id" do
    it "updates the movie and redirects to it" do
      patch movie_path(movie), params: { movie: { title: "Star Wars: A New Hope" } }
      expect(movie.reload.title).to eq("Star Wars: A New Hope")
      expect(response).to redirect_to(movie_path(movie))
    end
  end

  describe "DELETE /movies/:id" do
    it "destroys the movie and redirects to the list" do
      expect {
        delete movie_path(movie)
      }.to change(Movie, :count).by(-1)
      expect(response).to redirect_to(movies_path)
    end
  end
end
