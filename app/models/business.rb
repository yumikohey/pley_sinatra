class Business < ActiveRecord::Base
	has_many :violations
	has_many :inspections
end
