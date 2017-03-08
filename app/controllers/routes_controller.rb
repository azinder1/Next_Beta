class RoutesController < ApplicationController
  def index
  @route = Route.new
  @routes = Route.all
  @geojson = Array.new
  build_geojson(@routes, @geojson)
  respond_to do |format|
    format.html {render :index}
    format.json { render json: @geojson }
  end
end

def build_geojson(routes, geojson)
  routes.each do |route|
    geojson.push(route.build_route)
  end
end

def create
  @route = Route.new(route_params)
  if @route.save
    redirect_to routes_path
  else
     flash[:notice] = "Please add a marker on the map"
    redirect_to routes_path
  end
end

def show
  @route = Route.find(params[:id])
end
private
def route_params
  params.require(:route).permit(:name, :description, :lat, :lng, :difficulty_rating)
end

end
