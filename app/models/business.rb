class Business < ActiveRecord::Base
	has_many :violations
	has_many :inspections
	has_many :users
	has_many :comments
end
