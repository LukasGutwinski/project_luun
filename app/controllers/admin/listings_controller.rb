class Admin::ListingsController < ApplicationController

  def index
    @listings = Listing.all
  end

end
