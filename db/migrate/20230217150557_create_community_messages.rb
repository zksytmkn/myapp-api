class CreateCommunityMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :community_messages do |t|
      t.text :communityMessage_content
      t.references :user, foreign_key: true
      t.references :community, foreign_key: true

      t.timestamps
    end
  end
end
