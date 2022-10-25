class RemovePasswordConfirmFromUsers < ActiveRecord::Migration[7.0]
  def down
    remove_column :users, :password_confirm, :string
  end
end
