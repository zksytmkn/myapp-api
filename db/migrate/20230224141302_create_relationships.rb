class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.integer :following_id, null: false
      t.integer :followed_id, null: false
      t.index [:following_id, :followed_id], unique: true
      t.timestamps
    end
  end
end
