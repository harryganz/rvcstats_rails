class Family < ActiveRecord::Base
	#Relationships
	has_many :genera, :class_name => 'Gen'

	#Validations
	CAP_REGEX = /\A[A-Z][a-z]+\Z/ 
	COM_REGEX = /\A[A-Za-z\s]+\Z/ #Letters and spaces

	validates :family_name, :presence => true, 
	  :uniqueness => true, 
	  :format => {:with => CAP_REGEX, 
	  :message => 'must start with capital letter'} 

	validates :common_name,
		:allow_blank => true,
	    :format => {:with => COM_REGEX,
	  	:message => 'must contain only letters and 
	  	spaces'}

	validates :family_nr, :presence => true, 
	  :numericality => {:only_integer => true},
	  :uniqueness => true


end
