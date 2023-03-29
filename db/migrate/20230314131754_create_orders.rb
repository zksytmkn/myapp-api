class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :billing_amount, null: false
      t.string :zipcode, null: false
      t.string :street, null: false
      t.string :building, null: false
      t.timestamps
    end
  end
end
