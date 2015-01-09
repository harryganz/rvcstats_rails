class Strat < ActiveRecord::Base
	#Relationships
	has_many :samples

	#Validations
	CD_REGEX = /\A[A-Z]{3}\s{1}(?:[A-Z]{4}|[A-Z]{3}[.]{1})\Z/
	NAME_REGEX = /\A[A-Za-z\s]+\Z/

	validates :year, :presence => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than => 1986, 
	  	:less_than => 9999}

	validates :strat,
	  :presence => true,
	  :uniqueness => {
	  	:scope => [:year, :region, :prot]
	  }

	validates :region, 
	  :presence => true,
	  :format => {
	  	:with => CD_REGEX,
	  	:message => 'must consist of 
	  	3 capital letters, a space, and 
	  	4 capital letters'
	  }

	validates :prot,
	  :inclusion => {
	  	:in => [0, 1],
	  	:message => 'must be 0 or 1'
	  }

	validates :grid_size,
	 :presence => true, 
	 :numericality => {
	 	:only_integer => true,
	 	:greater_than => 0
	 }

	validates :ntot,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than_or_equal_to => 0
	  }
end
