class AddUserProfileToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :userProfile, :string , :limit=> 255 , null: false
  end
end
