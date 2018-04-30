class ReservationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_restaurant

  def index
    @reservations = @restaurant.reservations
  end

  def create
    @reservation = @restaurant.reservations.new(reservation_params)
    render json: { errors: @reservation.errors.full_messages }, status: 422 unless @reservation.save
  end

  def update
    @reservation = Reservation.find(params[:id])
    render json: { errors: @reservation.errors.full_messages }, status: 422 unless @reservation.update(reservation_params)
  end

  private

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def reservation_params
    params.permit(:table_id, :shift_id, :guest_id, :guest_count, :reservation_at)
  end
end
