class PagesController < ApplicationController
  def home
    Brand.all
    @brands = Brand.all
    @car_hash = create_hash_cars(@brands)
  end

  def create_hash_cars(brands)
    hash = {}
      brands.each do |brand|
        brand.brand_models.each do |model|
        if hash[brand.name]
          hash[brand.name] << model.name
        else
          hash[brand.name] = [model.name]
        end
      end
    end
    return hash
  end
end
