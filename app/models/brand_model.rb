class BrandModel < ApplicationRecord
  belongs_to :brand
  has_many :listings
end
