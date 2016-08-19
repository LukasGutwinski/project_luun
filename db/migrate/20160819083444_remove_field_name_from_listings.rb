class RemoveFieldNameFromListings < ActiveRecord::Migration[5.0]
  def change
    remove_column :listings, :brand, :string
  end
end
