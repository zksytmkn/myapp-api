class AddConfirmationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :confirmation_status, :integer, default: 1, null: false
    add_column :users, :confirmation_token, :string, limit: 64
    add_column :users, :expiration_date, :datetime
  end
end
