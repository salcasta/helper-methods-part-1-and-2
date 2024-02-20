class MoviesController < ApplicationController
  def new
    @the_movie = Movie.new

    ## NOT NEEDED
    #render "movies/new"
  end

  def index
    matching_movies = Movie.all

    @list_of_movies = matching_movies.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @list_of_movies
      end

      format.html
    end
  end

  def show
    #@the_movie = Movie.where(id: params.fetch(:id)).first
    @the_movie = Movie.find_by(id: params.fetch(:id)).first
  end

  def create
    @the_movie = Movie.new
    @the_movie.title = params.fetch("query_title")
    @the_movie.description = params.fetch("query_description")

    if @the_movie.valid?
      @the_movie.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      render "new"
    end
  end

  def edit
    the_id = params.fetch(:id)

    matching_movies = Movie.where(id: the_id)

    @the_movie = matching_movies.first

    # not needed
    # render template: "movies/edit" 
  end

  def update
    the_id = params.fetch(:id)
    the_movie = Movie.where(id: the_id).first

    the_movie.title = params.fetch("query_title")
    the_movie.description = params.fetch("query_description")

    if the_movie.valid?
      the_movie.save
      redirect_to movie_url(the_movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(the_movie), alert: "Movie failed to update successfully." 
    end
  end

  def destroy
    the_id = params.fetch(:id)
    the_movie = Movie.where(id: the_id).first

    the_movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
