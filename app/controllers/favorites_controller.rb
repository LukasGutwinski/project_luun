class FavoritesController < ApplicationController


  def create
    @favorite = Favorite.new
    @favorite.user = current_user
    @favorite.listing = Listing.find(params[:listing_id])
    @favorite.save
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
  end
end
