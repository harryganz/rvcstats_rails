class Animal < ActiveRecord::Base
	#Relationships
	has_many :samples
	
	#Validations
	SPC_REGEX = /\A[a-z.]+\Z/ #Only lowercase letters and periods
	COM_REGEX = /\A[A-Za-z\s]+\Z/ #Letters and spaces
	CD_REGEX = /\A[A-Z]{3}\s{1}(?:[A-Z]{4}|[A-Z]{3}[.]{1})\Z/
	# 3 Caps + space + (4 Caps Or 3 Caps and a period)

	validates :species_name, :presence => true,
	  :format => {:with => SPC_REGEX,
	  :message => 'must contain only lowercase letters'},
	  :uniqueness => {:scope => :genus_name,
	  :message => 'must be unique within each genus'}

	validates :genus_name, :presence => true,
	  :uniqueness => {:scope => :family_name,
	  	:message => 'must be unique within each family'},
 	  :format => {:with => CAP_REGEX,
 	  :message => 'must start with capital letter'}

 	validates :family_name, :presence => true,  
	  :format => {:with => CAP_REGEX, 
	  :message => 'must start with capital letter'} 

	validates :common_name, 
	  :allow_blank => true,
	  :format => {:with => COM_REGEX, 
	  :message => 'must contain only letters and spaces'}

	validates :species_cd, :presence => true,
	  :format => {:with => CD_REGEX, 
	  :message => 'must be capitalized, with first 4 letters
	  of the genus and first 3 of the species'},
	  :uniqueness => true

	#Scopes
	scope :sci_name, -> sciname {where(:genus_name => sciname.split(' ')[0], :species_name => sciname.split(' ')[1])} 
		#TODO check that this doesn't break when sciname is nil
end
