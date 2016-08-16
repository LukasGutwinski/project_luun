class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def index
    @listings = Listing.all
  end

  def show
  end

  def new
    @listing = Listing.new
  end

  def edit
  end

  def create
    @listing = Listing.new(listing_params)

    #doing this for testing purposes until the login module is added
    @listing.user = User.find(1)
    # @listing.user = current_user
    @listing.save

    redirect_to listings_path(@listing)
  end

  def update
    @listing.update(listing_params)

  end

  def destroy
    @listing.destroy
    redirect_to listings_path
  end

  private

  def listing_params
    params.require(:listing).permit(:brand, :photo, :photo_cache, :model, :title, :mileage, :description, :price, :year, :condition, :origin, :city)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
