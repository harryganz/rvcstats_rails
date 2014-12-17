class Region < ActiveRecord::Base
	#Relationships 
	has_many :strata, :class_name => 'Strat'

	#Validations
	NAME_REGEX = /\A[A-Za-z\s]+\Z/
		#Letters, spaces only
	CD_REGEX = /\A[A-Z]{3}\s{1}[A-Z]{4}\Z/
		#3 Caps a space and 4 Caps

	validates :region_cd, 
	  :presence => true,
	  :format => {
	  	:with => CD_REGEX,
	  	:message => 'must consist of 
	  	3 capital letters, a space, and 
	  	4 capital letters'
	  }

	validates :region_name,
	  :presence => true,
	  :format => {
	  	:with => NAME_REGEX,
	  	:message => 'must contain
	  	only letters and spaces'
	  }

	validates :region_nr,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than => 0,
	  	:less_than => 100
	  }
end
