class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.integer :status, null: false
      t.index [:order_id, :product_id], unique: true
      t.timestamps
    end
  end
end
