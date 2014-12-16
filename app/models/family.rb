class Family < ActiveRecord::Base
	#Relationships
	has_many :genera, :class_name => 'Gen'

	#Validations
	CAP_REGEX = /^[A-Z][a-z]+$/ 
	COM_REGEX = /^[A-Za-z\s]+$/ #Letters and spaces

	validates :family_name, :presence => true, 
	  :uniqueness => true, 
	  :format => {:with => CAP_REGEX, 
	  :message => 'must start with capital letter'} 

	validates :common_name,
	  format => {:with => COM_REGEX,
	  	:message => 'must contain only letters and 
	  	spaces'}

	validates :family_nr, :presence => true, 
	  :numericality => {:only_integer => true},
	  :uniqueness => true


end
