class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    if current_user
      @reservation = @restaurant.reservations.build
    end
  end

end
