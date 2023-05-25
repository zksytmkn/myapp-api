class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, unique: true
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false
      t.string :prefecture
      t.string :zipcode
      t.string :street
      t.string :building
      t.string :profile_text
      t.boolean :is_guest, default: false
      t.timestamps
    end
  end
end
