class AddColumnsToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :search_brand, :string
    add_column :listings, :search_model, :string
  end
end
