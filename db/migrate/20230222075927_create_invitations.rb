class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.integer :inviting_id, null: false
      t.integer :invited_id, null: false
      t.references :community, foreign_key: true, null: false
      t.index [:invited_id, :community_id], unique: true
      t.timestamps
    end
  end
end
