class PlacesController < ApplicationController

  def index
    @places = Place.all
    @current_user = User.find_by({ "id" => session["user_id"] })
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    @posts = Post.where({ "place_id" => @place["id"] })
    if @current_user
      @posts = Post.where({ "place_id" => @place["id"] ,"user_id" => @current_user["id"]})
  end
end

  def new
    @place = Place.new
  end

  def create
  if @current_user
      @place = Place.new
      @place["name"] = params["place"]["name"]
      @place.save
  else
    flash["notice"] = "Sign in to add new places."
  end
    redirect_to "/places"
  end

end
