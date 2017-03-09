class RoutesController < ApplicationController

  def index
    @route = Route.new
    @routes = Route.all
    @geojson = Array.new
    build_geojson(@routes, @geojson)
    respond_to do |format|
      format.html {render :index}
      format.json { render json: @geojson }
      format.js
    end
  end

  def build_geojson(routes, geojson)
    routes.each do |route|
      geojson.push(route.build_route)
    end
  end

  def new
    @route = Route.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    if cookies[:lat_lng]
      @lat_lng = cookies[:lat_lng].split("|")
    end
    @lat = @lat_lng[0]
    @lng = @lat_lng[1]
    @route = Route.new(route_params)
    @route[:user_id] = current_user.id
    @route[:lat] = @lat
    @route[:lng] = @lng
    if @route.save
      redirect_to routes_path
    else
       flash[:notice] = "Please add a marker on the map"
      redirect_to routes_path
    end
  end

  def show
    @comment = Comment.new
    @route = Route.find(params[:id])
    @user = User.find(@route.user_id)
    respond_to do |format|
      format.html
      format.js
    end
  end

private

  def route_params
    params.require(:route).permit(:name, :description, :lat, :lng, :difficulty_rating)
  end

end
