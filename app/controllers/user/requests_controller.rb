class User::RequestsController < ApplicationController

  def index
    @requests = current_user.requests
  end

end
