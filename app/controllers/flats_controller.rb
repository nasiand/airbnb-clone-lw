class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_flat, only: [:show, :edit, :update, :destroy]

  def index
    if params[:size].present?
      @flats = Flat.where("city ILIKE ? AND size >= ?", params[:city], params[:size])
    else
      @flats = Flat.where("city ILIKE ?", params[:city])
    end

    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        info_window: render_to_string(partial: "info_window", locals: { flat: flat }),
        image_url: helpers.asset_url('house-icon.png')
      }
    end
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @flat.update(flat_params)

    redirect_to flat_path(@flat)
  end

  def destroy
    @flat.destroy

    redirect_to flats_path
  end

  private

  def find_flat
    @flat = Flat.find(params[:id])
  end
  
  def flat_params
    params.require(:flat).permit(:title, :address, :description, :city, :price, :size)
  end
end
