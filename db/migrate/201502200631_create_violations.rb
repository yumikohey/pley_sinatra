class CreateViolations < ActiveRecord::Migration

	def change
		create_table :violations do |t|
			t.date :date
			t.string :risk_category
			t.string :description, null: true
			t.integer :business_id
			t.integer :violation_type_id

			t.timestamps
		end
	end
end
