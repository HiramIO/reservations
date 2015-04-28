class ReservationsController < ApplicationController
  before_filter :ensure_logged_in, only: [:create, :destroy]
  before_filter :load_restaurant
  # before_filter :load_user

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = @restaurant.reservations.build(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.restaurant_id = @restaurant.id
    seats_reserved = @restaurant.reservations.where("time > ? and time < ?", @reservation.time.beginning_of_hour, @reservation.time.beginning_of_hour + 1.hour).map(&:party_size).sum

    # seats_reserved = @restaurant.reservations
    #                                   .where("date > :start_time AND date < :end_time", {
    #                                     start_time: @reservation.date,
    #                                     end_time: @reservation.date + 1.hours
    #                                   }).map(&:party_size).sum


    seats_available = @restaurant.capacity - seats_reserved

    if @reservation.party_size >= seats_available
      flash[:alert] = "This reservation cannot be made."
      render :new
    else
      @reservation.save
      flash[:notice] = "Your reservation has been created."
      redirect_to restaurants_path
    end
  end


  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
  end

  private
  def reservation_params
    params.require(:reservation).permit(:time, :restaurant_id, :user_id, :party_size)
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  # def load_user
  #   @user = User.find(params[:user_id])
  # end

end
