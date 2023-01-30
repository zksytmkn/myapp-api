class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :name, null: false
      t.text :text, null: false
      t.string :poster, null: false
      t.boolean :like
      t.boolean :dislike
      t.timestamps
    end
  end
end
