class Record < ActiveRecord::Base
	#Relationships 
	belongs_to :station
	belongs_to :animal

	#Validations
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

	validates :time_seen,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true
	  },
	  :inclusion => {:in => [1,2,3]}

	validates :animal_id,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true
	  }

	validates :station_id,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true
	  }
end
