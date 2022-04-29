class MoviesController < ApplicationController
  def index
    # @movies = Movie.all
    @movies = Movie.joins(:director)

    if params[:query].present?
      # params[:query] => "Superman"
      # @movies = @movies.where(title: params[:query])

      # SQL LIKE "%keyword%"
      # Batman and Superman
      # Superman Returns
      # @movies = @movies.where("LOWER(title) LIKE ?", "%#{params[:query].downcase}%")
      # @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%")

      # Search in multiple columns
      # sql = "title ILIKE ? OR synopsis ILIKE ?"
      # @movies = @movies.where("title ILIKE ? OR synopsis ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
      # @movies = @movies.where("title ILIKE :query OR synopsis ILIKE :query", :query => "%#{params[:query]}%")

      # sql_query = " \
      #   movies.title ILIKE :query \
      #   OR movies.synopsis ILIKE :query \
      #   OR directors.first_name ILIKE :query \
      #   OR directors.last_name ILIKE :query \
      # "

      # Full text search in Postgres
      # sql_query = " \
      #   movies.title @@ :query \
      #   OR movies.synopsis @@ :query \
      #   OR directors.first_name @@ :query \
      #   OR directors.last_name @@ :query \
      # "

      # @movies = @movies.where(sql_query, :query => "%#{params[:query]}%")

      @movies = @movies.search_by_title_and_synopsis(params[:query])
    end
  end
end
