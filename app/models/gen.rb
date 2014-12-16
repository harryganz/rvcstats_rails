class Gen < ActiveRecord::Base
	# Relationships
	has_many :species, :class_name => 'Animal'
	belongs_to :family

	#Validations
	CAP_REGEX = /\A[A-Z][a-z]+\Z/
	COM_REGEX = /\A[A-Za-z\s]+\Z/ #Letters and spaces

	validates :genus_name, :presence => true,
 	  :format => {:with => CAP_REGEX,
 	  :message => 'must start with capital letter'}

 	validates :common_name,
 	  :allow_blank => true,
	  :format => {:with => COM_REGEX,
	  :message => 'must contain only letters and 
	  	spaces'}

	validates :family_id, :presence => true,
	  :numericality => {:only_integer => true}


end
