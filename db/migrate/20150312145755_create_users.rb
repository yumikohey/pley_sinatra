class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :screen_name, :null => false
      t.string :email, :null => false
      t.string :hashed_password, :null => false
      
      t.timestamps
    end
    add_index :users, :email, :unique => true
  end
end