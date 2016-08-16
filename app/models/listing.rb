class Listing < ApplicationRecord
  belongs_to :user
  has_attachments :photos, maximum: 10
  validates :brand, length: { minimum: 3, maximum: 20 }

end
