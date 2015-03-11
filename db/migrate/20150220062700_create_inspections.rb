class CreateInspections < ActiveRecord::Migration

	def change
		create_table :inspections do |t|
			t.integer :score
			t.date :date
		    t.integer :business_id
		    t.string :inspect_type

			t.timestamps
		end
	end
end
