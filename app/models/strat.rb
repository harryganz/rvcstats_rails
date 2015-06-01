class Strat < ActiveRecord::Base
	#Relationships
	has_many :samples
	has_many :diversities

	#Validations
	CD_REGEX = /\A[A-Z]{3}\s{1}(?:[A-Z]{4}|[A-Z]{3}[.]{1})\Z/
	NAME_REGEX = /\A[A-Za-z\s]+\Z/

	validates :year,
	:presence => true,
	:numericality => {
		:greater_than => 1993,
		:less_than_or_equal_to => Time.now.year,
		:message => 'must be between 1994 and the current year'
	}


	validates :strat,
	  :presence => true,
	  :uniqueness => {
	  	:scope => [:year, :region, :prot],
	  	:message => 'must be unique for each combination of
	  	year, region, and protected status'
	  }

	validates :region,
	  :presence => true,
	  :inclusion => {
			:in => ['FLA KEYS', 'DRTO', 'SEFCRI']
		}

	validates :prot,
		:numericality => true,
	  :inclusion => {
	  	:in => [0, 1, 2],
	  	:message => 'must be 0, 1 or 2'
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

	validates :rfhab,
	 :presence => true

	validates :rugosity_cd,
	 :presence => true,
	 :numericality => {
		:only_integer => true,
		:greater_than => -1,
		:less_than => 3
	}

end
