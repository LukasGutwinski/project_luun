class FavoritesController < ApplicationController

  def index
    favorites = Favorite.find(current_user)
    @listing = favorite.listing
  end

  def create
    @favorite = Favorite.new
    @favorite.user = current_user
    @favorite.listing = Listing.find(params[:listing_id])
    @favorite.save
    respond_to do |format|
      format.html {redirect_to listings_path}
      format.js
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
  end
end
