class Psu < ActiveRecord::Base
	#Relationships
	belongs_to :stratum, :class_name => :strat,
	 :foreign_key => 'strat_id'
	has_many :stations

	#Validations
	validates :psu_cd, 
	  :presence => true,
	  :uniqueness => {
	  	:scope => :stratum,
	  	:message => 'must be 
	  	unique within each stratum'
	  }
	  #TODO: Make unique within year, region instead

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

	validates :strat_id, 
	  :presence => true,
	  :numericality => {
	  	:only_integer => true
	  }
end
