class RemovePasswordFieldFromTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :password, :text
  end
end
