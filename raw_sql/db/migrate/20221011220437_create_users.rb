class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name ,  null: false  , unique: true
      t.string :email , null: false , unique: true
      t.text :password , null: false
      t.string :profile , :limit=> 255 , null: false
      t.string :type ,    :limit=> 1 , default: 1 , null: false
      t.string :phone ,   :limit=> 20
      t.string :address , :limit=> 255 
      t.date :dob
      t.integer :create_user_id , default: 1 , null: false
      t.integer :updated_user_id , default: 1 , null: false
      t.integer :deleted_user_id
      t.timestamps 
      t.datetime :deleted_at
    end
  end
end
