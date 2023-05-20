class CreateOrderMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :order_messages do |t|
      t.text :content, null: false
      t.references :user, foreign_key: true, null: false
      t.references :order, foreign_key: true, null: false
      t.timestamps
    end
  end
end
