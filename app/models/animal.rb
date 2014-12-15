class Animal < ActiveRecord::Base
	#Relationships
	belongs_to :genus, :class_name => 'Gen', :foreign_key => 'gen_id'
end
