class Sample < ActiveRecord::Base
	#Relationships 
	belongs_to :stratum, :class => 'Strat', :foreign_key => 'strat_id' 
	belongs_to :species, :class => 'Animal', :foreign_key => 'animal_id'

	#Validations
	CD_REGEX = /\A[A-Z]{3}\s{1}(?:[A-Z]{4}|[A-Z]{3}[.]{1})\Z/

	validates :year, 
		:presence => true, 
		:numericality => {
			:greater_than => 1986
			:less_than_or_equal_to => Time.now.year
			:message => 'must be between 1987 and the current year'
		}

	validates :month,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than => 0,
	  	:less_than => 13
	  }

	validates :day,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than => 0,
	  	:less_than => 32
	  }

	validates :region, 
	  :presence => true,
	  :format => {
	  	:with => CD_REGEX,
	  	:message => 'must consist of 
	  	3 capital letters, a space, and 
	  	4 capital letters'
	  }
	  # TODO Inclusion Validators

	validates :strat,
	  :presence => true
	  }
	  # TODO Format and inclusion validations
	  # Possibly conditional inclusion based on region

	validates :primary_sample_unit, 
	  :presence => true,
	  :uniqueness => {
	  	:scope => [:year, :region],
	  	:message => 'must be 
	  	unique within each year/region'
	  }

	validates :zone_nr,
	  :allow_blank => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than_or_equal_to => 0
	  }

	validates :subregion_nr,
	  :allow_blank => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than_or_equal_to => 0
	  }

	validates :mapgrid_nr,
	  :allow_blank => true,
	  :numericality => {
	  	:only_integer => true
	  }

	validates :mpa_nr,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than_or_equal_to => 0
	  }

	validates :time_seen,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true
	  },
	  :inclusion => {:in => [1,2,3]}

	validates :station_nr,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than => 0,
	  	:less_than => 11
	  },
	  :uniqueness => {
	  	:scope => :primary_sample_unit,
	  	:message => 'must be unique within each 
	  	primary sampling unit'
	  }

	validates :lat_degrees,
	  :presence => true,
	  :numericality => {
	  	:greater_than_or_equal_to => -90,
	  	:less_than_or_equal_to => 90
	  }

	validates :lon_degrees,
	  :presence => true,
	  :numericality => {
	  	:greater_than_or_equal_to => -180,
	  	:less_than_or_equal_to => 180
	  }

	validates :depth,
	  :presence => true,
	  :numericality => {
	  	:greater_than_or_equal_to => 0,
	  	:less_than_or_equal_to => 40
	  }

	validates :underwater_visibility,
	  :presence => true,
	  :numericality => {
	  	:greater_than_or_equal_to => 0
	  }

	validates :habitat_cd,
	  :presence => true
	  # TODO inclusion validators
	  # Possibly conditional based on region

	validates :species_cd,
		:presence => true,
		:format => {
			:with => CD_REGEX,
			:message => 'must consist of 
	  	3 capital letters, a space, and 
	  	4 capital letters'
		}

		# TODO Validator to make sure it matches available
		# species

	validates :num,
	  :presence => true,
	  :numericality => {
	  	:greater_than_or_equal_to => 0
	  }

	validates :len,
	  :presence => true,
	  :numericality => {
	  	:greater_than_or_equal_to => 0
	  }

	validates :animal_id,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true
	  }

	validates :strat_id,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true
	  }

end
