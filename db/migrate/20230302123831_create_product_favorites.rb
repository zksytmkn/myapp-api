class CreateProductFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :product_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.index [:user_id, :product_id], unique: true
      t.timestamps
    end
  end
end
