class CreateProductComments < ActiveRecord::Migration[7.0]
  def change
    create_table :product_comments do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
