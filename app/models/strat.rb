class Strat < ActiveRecord::Base
	#Relationships
	belongs_to :region
	belongs_to :year
	# has_many :psus

	#Validations
	#TODO: Add validations for code based on
	# region
	validates :strat_cd,
	  :presence => true

	validates :protected,
	  :inclusion => {
	  	:in => [true, false],
	  	:message => 'must be true or false'
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

	validates :year_id,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true
	  }

	validates :region_id,
	 :presence => true,
	 :numericality => {
	 	:only_integer => true
	 }
end
