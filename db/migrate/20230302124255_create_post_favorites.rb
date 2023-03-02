class CreatePostFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :post_favorites do |t|

      t.timestamps
    end
  end
end
