class CreatePostUnfavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :post_unfavorites do |t|

      t.timestamps
    end
  end
end
