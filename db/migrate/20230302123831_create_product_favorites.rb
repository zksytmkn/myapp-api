class CreateProductFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :product_favorites do |t|

      t.timestamps
    end
  end
end
