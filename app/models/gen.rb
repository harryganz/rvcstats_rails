class Gen < ActiveRecord::Base
	# Relationships
	has_many :species, :class_name => 'Animal'
	belongs_to :family
end
