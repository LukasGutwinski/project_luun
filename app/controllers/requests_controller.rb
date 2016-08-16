class RequestsController < ApplicationController

  def create
    @request = Request.new
    @request.user = current_user
    @request.comment = request_params[:comment]
    @request.status = "Waiting for approval"
    @request.listing = Listing.find(params[:listing_id])
    @request.save
  end

  private

  def request_params
    params.require(:request).permit(:comment)
  end

end
