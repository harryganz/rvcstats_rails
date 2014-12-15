class Family < ActiveRecord::Base
	#Relationships
	has_many :genera, :class_name => 'Gen'
end
