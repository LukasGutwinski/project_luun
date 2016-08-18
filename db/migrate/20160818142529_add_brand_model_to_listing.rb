class AddBrandModelToListing < ActiveRecord::Migration[5.0]
  def change
    add_reference :listings, :brand_model, foreign_key: true
  end
end
