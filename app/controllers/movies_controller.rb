class MoviesController < ApplicationController
  def new
    @movie = Movie.new

    ## NOT NEEDED
    #render "movies/new"
  end

  def index
    @movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @list_of_movies
      end

      format.html
    end
  end

  def show
    #@the_movie = Movie.where(id: params.fetch(:id)).first
    @movie = Movie.find_by(id: params.fetch(:id))
  end

  def create
    @movie = Movie.new
    @movie.title = params.fetch("title")
    @movie.description = params.fetch("description")

    if @movie.valid?
      @movie.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      render "new"
    end
  end

  def edit
    @movie = Movie.find(params.fetch(:id))

    # not needed
    # render template: "movies/edit" 
  end

  def update
    the_id = params.fetch(:id)
    the_movie = Movie.where(id: the_id).first

    the_movie.title = params.fetch("title")
    the_movie.description = params.fetch("description")

    if movie.valid?
      movie.save
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
