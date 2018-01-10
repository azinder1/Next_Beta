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
    if current_user
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
      end
    else
      flash[:notice] = "Please sign in before adding a route"
      redirect_to routes_path
    end
  end

  def show
    @comment = Comment.new
    @route = Route.find(params[:id])
    @user = User.find(@route.user_id)
    @results = HTTParty.get("http://api.wunderground.com/api/" + ENV["WUNDERGROUND_KEY"] + "/conditions/q/" +  @route.lat + "," + @route.lng + ".json",)
    if @results["response"] !=  {"version"=>"0.1",
 "termsofService"=>"http://www.wunderground.com/weather/api/d/terms.html",
 "features"=>{"conditions"=>1},
 "error"=>{"type"=>"querynotfound", "description"=>"No cities match your search query"}}
      if @results["current_observation"]["display_location"]["country"] == "US"
        @ten_day_results = HTTParty.get("http://api.wunderground.com/api/" + ENV["WUNDERGROUND_KEY"] + "/forecast10day/q/" +  @results["current_observation"]["display_location"]["state"] + "/" + @results["current_observation"]["display_location"]["city"] + ".json",)
        @day_one = @ten_day_results["forecast"]["txt_forecast"]["forecastday"][2]
        @day_two= @ten_day_results["forecast"]["txt_forecast"]["forecastday"][4]
        @day_three = @ten_day_results["forecast"]["txt_forecast"]["forecastday"][6]
      end
    else
      @results = nil
    end
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
