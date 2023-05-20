class CreateProductFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :product_favorites do |t|
      t.references :user, foreign_key: true, null: false
      t.references :product, foreign_key: true, null: false
      t.index [:user_id, :product_id], unique: true
      t.timestamps
    end
  end
end
