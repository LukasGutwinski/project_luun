class Listing < ApplicationRecord
  belongs_to :user
  has_many :requests
  has_attachments :photos, maximum: 10
end
