class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :destroy]
  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
    @flat = Flat.find(params[:flat_id])
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end


  private

  def booking_params
    params.require(:booking).permit(:check_in, :check_out)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
