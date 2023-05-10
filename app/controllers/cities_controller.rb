class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    @gossips = @city.gossips
  end

  def index
    @cities = City.all
  end
end
