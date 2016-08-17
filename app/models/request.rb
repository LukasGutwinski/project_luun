class Request < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  def approve
    self.status = "Approved"
  end

  def cancel_approval
    self.status = "Waiting for approval"
  end

end
