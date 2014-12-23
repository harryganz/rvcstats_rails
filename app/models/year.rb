class Year < ActiveRecord::Base
	# Relationships 
	has_many :strata, :class_name => 'Strat'
	has_many :psus

	# Validations
	validates :year, :presence => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than => 1986, 
	  	:less_than => 9999}
end
