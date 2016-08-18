require 'json'

class PagesController < ApplicationController
  def home
    @listings = Listing.all
    @brands = get_unique_brands(@listings)
    @models = get_unique_models(@listings)
    @hash = create_hash_cars(@listings)
  end

  def modeltype
    @listings = Listing.all
    @brands = get_unique_brands(@listings)
    @models = get_unique_models(@listings)
  end

  def json
    @listings = Listing.all
    render @listongs.to_json
  end


  private

  def create_hash_cars(listings)

    hash = {}
    listings.each do |listing|
      if hash[listing.brand]
        hash[listing.brand] << listing.model
      else
        hash[listing.brand] = [listing.model]
      end
    end
    return hash
  end

  def get_unique_brands(listings)
    brands = []
    listings.each do |listing|
      brands << listing.brand
    end
    return brands.uniq
  end

  def get_unique_models(listings)
    model = []
    listings.each do |listing|
      model << listing.model
    end
    return model.uniq
  end

end
