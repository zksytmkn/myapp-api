class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.references :user, foreign_key: true, null: false
      t.references :community, foreign_key: true, null: false
      t.timestamps
    end
  end
end
