class CreateOrderMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :order_messages do |t|

      t.timestamps
    end
  end
end
