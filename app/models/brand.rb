class Brand < ApplicationRecord
  has_many :listings
  has_many :brand_models
end
