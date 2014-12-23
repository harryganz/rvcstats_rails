class Psu < ActiveRecord::Base
	#Relationships
	belongs_to :stratum, :class_name => 'Strat',
	 :foreign_key => 'strat_id'
	belongs_to :year
	belongs_to :region
	has_many :stations

	#Callbacks
	before_validation :match_year_and_region
	 #TODO: Not the most elegant solution, but it works

	#Read-only attributes
	attr_readonly :year, :region

	#Validations
	validates :psu_cd, 
	  :presence => true,
	  :uniqueness => {
	  	:scope => [:year, :region],
	  	:message => 'must be 
	  	unique within each year/region'
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

	validates :zone_nr,
	  :allow_blank => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than_or_equal_to => 0
	  }
	  #TODO: Make sure zone matches stratum

	validates :subregion_nr,
	  :allow_blank => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than_or_equal_to => 0
	  }
	  #TODO: Make sure subregion matches region

	validates :mapgrid_nr,
	  :allow_blank => true,
	  :numericality => {
	  	:only_integer => true
	  }
	  #TODO: Make sure mapgrid_nr is valid

	validates :mpa_nr,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than_or_equal_to => 0
	  }

	validates :strat_id, 
	  :presence => true,
	  :numericality => {
	  	:only_integer => true
	  }

	# Custom Validation to check that protected status is the same as stratum
	validate :valid_mpa_nr_for_stratum

	private 
		# Before validation set the year to the 
		# stratum year and the region
		# to the stratum region
		def match_year_and_region
			self.year = self.stratum.year
			self.region = self.stratum.region
		end

		# On validation make sure that 
		# the MPA_NR is valid for the stratum
		def valid_mpa_nr_for_stratum
			prot = self.mpa_nr > 0 ? 1:0
			unless prot == self.stratum.protected
				raise 'psu must have the same protected status as its 
				stratum'
			end
		end
end
