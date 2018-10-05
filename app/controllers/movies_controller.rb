class MoviesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_found
    flash[:notice] = "Moive recrod cannot be found."
    redirect_to movies_path
  end

  def movies_with_filters
    if params[:review_threshold]
      @movies = Movie.with_good_reviews(params[:review_threshold])
    end
    @movies = @movies.for_kids if params[:for_kids]
    if params[:days_reviewed]
      @movies = @movies.recently_reviewed(params[:days_reviewed])
    end
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
  
  def index
    @movies = Movie.all
  end
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  def new
    @movie = Movie.new
  end
  
  def create
    @movie = Movie.create movie_params
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created"
      redirect_to movies_path
    else
      render 'new'
    end
  end
  
  def edit
    @movie = Movie.find params[:id]
  end

 def update
    @movie = Movie.find params[:id]
    #@movie.update_attributes!(params[:movie])  # old way
    @movie.update_attributes!(movie_params)  # new way  
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
  
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end