class CreateComments < ActiveRecord::Migration
  def change
  	create_table :comments do |t|
  	  t.string :content, :null => false
      t.integer :business_id
      t.integer :user_id

      t.timestamps
  	end
  end
end
