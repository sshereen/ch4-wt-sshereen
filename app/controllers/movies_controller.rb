# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end
    
def show
  id = params[:id] # retrieve movie ID from URI route
  @movie = Movie.find(id) # look up movie by unique ID
  # will render app/views/movies/show.html.haml by default
end
    
    

    
    # add below all other methods
  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end