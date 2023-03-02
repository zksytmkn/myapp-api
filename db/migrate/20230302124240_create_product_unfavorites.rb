class CreateProductUnfavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :product_unfavorites do |t|

      t.timestamps
    end
  end
end
