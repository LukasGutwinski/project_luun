class Request < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  def create
  	raise
  end
end
