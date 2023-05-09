class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :category, null: false
      t.string :prefecture, null: false
      t.integer :price, null: false
      t.integer :stock, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
