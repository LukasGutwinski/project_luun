class AddPhotoToListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :photo, :string
  end
end
