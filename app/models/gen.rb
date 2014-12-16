class Gen < ActiveRecord::Base
	# Relationships
	has_many :species, :class_name => 'Animal'
	belongs_to :family

	#Validations
	CAP_REGEX = /^[A-Z][a-z]+$/
	COM_REGEX = /^[A-Za-z\s]+$/ #Letters and spaces

	validates :genus_name, :presence => true,
 	  :format => {:with => CAP_REGEX,
 	  :message => 'must start with capital letter'}

 	validates :common_name,
	  :format => {:with => COM_REGEX,
	  :message => 'must contain only letters and 
	  	spaces'}

	validates :family_id, :presence => true,
	  :numericality => {:only_integer => true}


end
