class RemoverememberTokenFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :remember_token
  end
end
