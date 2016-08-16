class ChangeIsSoldToFalse < ActiveRecord::Migration[5.0]
  def change
    change_column_default :listings, :is_sold, from: nil, to: false
  end
end
