class Request < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  validates_uniqueness_of :user_id, :scope => [:listing_id]

  def approve
    self.status = "Approved"
  end

  def cancel_approval
    self.status = "Waiting for approval"
  end

end
