class RequestsController < ApplicationController

  def index
    @listing = Listing.find(params[:listing_id])
    @requests = @listing.requests
  end

  def create
    @request = Request.new
    @request.user = current_user
    @request.comment = request_params[:comment]
    @request.status = "Waiting for approval"
    @request.listing = Listing.find(params[:listing_id])
    @request.save
    respond_to do |format|
      format.html { redirect_to listing_path(@request.listing) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    end

    def approve
      @listing = Listing.find(params[:listing_id])
      @request = Request.find(params[:id])
      @request.approve
      @request.save
    end

    def cancel_approval
      @listing = Listing.find(params[:listing_id])
      @request = Request.find(params[:id])
      @request.cancel_approval
      @request.save
    end


    private

    def request_params
      params.require(:request).permit(:comment)
    end

  end
