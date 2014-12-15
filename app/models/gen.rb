class Gen < ActiveRecord::Base
	has_many :species, :class_name => 'Animal'
end
