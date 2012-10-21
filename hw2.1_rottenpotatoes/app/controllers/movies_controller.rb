class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.getRatings
    @selected_ratings = @all_ratings.dup
    p "PARAMS:  " , params
    p "SESSION: " , session
    if params[:sort] != nil
      session[:sort]=params[:sort] 
    else
      if session[:sort] != nil
        redirect_to :ratings => params[:ratings], :sort => session[:sort]
      end
    end
    if params[:ratings] != nil || params[:commit] != nil
      @selected_ratings = params[:ratings].keys if params[:ratings] != nil
      session[:ratings]=params[:ratings]
    else
      if session[:ratings] != nil
        redirect_to :ratings => session[:ratings], :sort => params[:sort]
      end
    end
    if session[:sort] != nil
      @movies = Movie.find(:all, :order => session[:sort], :conditions => {:rating => @selected_ratings  })
    else
      @movies = Movie.find(:all, :conditions => {:rating => @selected_ratings })
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
