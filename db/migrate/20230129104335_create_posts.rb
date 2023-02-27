class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :name, null: false
      t.text :text, null: false
      t.boolean :like
      t.boolean :dislike
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
