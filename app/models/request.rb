class Request < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  def approve
    self.status = "Approved"
  end

end
