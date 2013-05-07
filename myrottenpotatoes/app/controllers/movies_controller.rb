# app/controllers/movies_controller.rb  
class MoviesController < ApplicationController
  def show
    if Movie.find_by_id(params[:id])==nil then
      flash[:notice] = "Number '#{params[:id]}' doesn't exist."
      redirect_to movies_path
    else
      @movie = Movie.find(params[:id])
    end
  end
  def new
    # default: render 'new' template
  end

  def index
    #@movies=Movie.order('title').all
    @movies = Movie.all

  end

  def create

    if params[:commit]=='Cancel' then
      redirect_to movies_path
    else
      @movie = Movie.create!(params[:movie])
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movie_path(@movie)
    end
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    if params[:commit]=='Cancel' then
      redirect_to movie_path(@movie)
    else
      @movie.update_attributes!(params[:movie])
      respond_to do |client_wants|
        client_wants.html do
          flash[:notice] = "#{@movie.title} was successfully updated."
          redirect_to movie_path(@movie)  
        end
        client_wants.xml  {  render :xml => @movie.to_xml    }
      end
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
