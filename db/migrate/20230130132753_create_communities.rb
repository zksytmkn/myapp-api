class CreateCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :communities do |t|
      t.string :name, null: false
      t.text :text, null: false
      t.string :maker, null: false
      t.timestamps
    end
  end
end
