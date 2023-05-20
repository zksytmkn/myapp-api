class CreatePostFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :post_favorites do |t|
      t.references :user, foreign_key: true, null: false
      t.references :post, foreign_key: true, null: false
      t.index [:user_id, :post_id], unique: true
      t.timestamps
    end
  end
end
