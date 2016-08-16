class Listing < ApplicationRecord
  belongs_to :user
  has_many :requests
  has_attachments :photos, maximum: 10
  validates :photos, presence: true
  validates :brand, :model, :origin, :city, length: { minimum: 3, maximum: 30 }
  validates :title, length: { minimum: 3, maximum: 60 }
  validates :condition, inclusion: { in: ["Used", "New", "Not roadworthy"], allow_nil: false }
  validates :description, length: { maximum: 500 }
  validates :mileage, :price, :year, numericality: { only_integer: true }
end
