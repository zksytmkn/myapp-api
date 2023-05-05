class CreateCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :communities do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
