class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity, null: false
      t.timestamps
    end
  end
end
