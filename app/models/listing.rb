class Listing < ApplicationRecord
  belongs_to :user
  has_many :requests
  belongs_to :brand
  belongs_to :brand_model
  has_attachments :photos, maximum: 10
  # validates :photos, presence: true
  # validates :brand, :model, presence: true
  validates :origin, :city, length: { minimum: 1, maximum: 30 }
  validates :title, length: { minimum: 3, maximum: 60 }
  validates :condition, inclusion: { in: ["Used", "New", "Not roadworthy"], allow_nil: false }
  validates :description, length: { maximum: 500 }
  validates :mileage, :price, :year, numericality: { only_integer: true }
  # searchkick
end
