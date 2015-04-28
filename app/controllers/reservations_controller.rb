class ReservationsController < ApplicationController
  before_filter :ensure_logged_in, only: [:create, :destroy]
  before_filter :load_restaurant
  before_filter :load_user

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = @restaurant.reservations.build(reservation_params)
    @reservation.user = current_user
    if @reservation.save
      redirect_to restaurants_path, notice: 'reservation created successfully'
    else
      render 'restaurants/show'
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
  end

  private
  def reservation_params
    params.require(:reservation).permit(:time, :restaurant_id, :user_id )
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def load_user
    @user = User.find(params[:user_id])
  end

end
