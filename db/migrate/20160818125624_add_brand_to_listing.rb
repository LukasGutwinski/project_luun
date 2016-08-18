class AddBrandToListing < ActiveRecord::Migration[5.0]
  def change
    add_reference :listings, :brand, foreign_key: true
  end
end
