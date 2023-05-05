class CreateOrderMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :order_messages do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :order, foreign_key: true
      t.timestamps
    end
  end
end
