class Listing < ApplicationRecord
  belongs_to :user
  has_attachments :photos, maximum: 10
end
