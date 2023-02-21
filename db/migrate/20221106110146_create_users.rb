class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :prefecture, null: false
      t.string :zipcode, null: false
      t.string :street, null: false
      t.string :building, null: false
      t.string :text, null: false
      t.string :password_digest, null: false
      t.boolean :activated, null: false, default: false
      t.boolean :admin, null: false, default: false
      t.timestamps
    end
  end
end
