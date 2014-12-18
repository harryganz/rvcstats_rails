class Psu < ActiveRecord::Base
	#Relationships
	belongs_to :strat
	has_many :stations

	#Validations
	validates :psu_cd, 
	  :presence => true,
	  :uniqueness => true

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

	validates :strat_id, 
	  :presence => true,
	  :numericality => {
	  	:only_integer => true
	  }
end
