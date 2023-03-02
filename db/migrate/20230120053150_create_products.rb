class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :text, null: false
      t.string :type, null: false
      t.string :prefecture, null: false
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.integer :inventory, null: false
      t.boolean :recommend
      t.boolean :purchased
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
