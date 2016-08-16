class RequestsController < ApplicationController

	def create
		@request = Request.new
    @request.user = current_user
    @request.listing = Listing.find(params[:listing_id])
    @request.save
	end

  private


end
