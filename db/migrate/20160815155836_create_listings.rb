class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :brand
      t.string :model
      t.string :title
      t.integer :mileage
      t.text :description
      t.integer :price
      t.integer :year
      t.string :condition
      t.string :origin
      t.string :city
      t.references :user, foreign_key: true
      t.boolean :is_sold

      t.timestamps
    end
  end
end
