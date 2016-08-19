module ListingsHelper
  def is_favorite?(listing)
    Favorite.where(user_id: current_user,
      listing_id: listing).first
  end
end
