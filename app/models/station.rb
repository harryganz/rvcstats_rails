class Station < ActiveRecord::Base
	#Relationships
	belongs_to :psu
	has_many :records

	#Callbacks
	before_validation :default_radius

	#Validations
	validates :station_nr,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than => 0,
	  	:less_than => 11
	  },
	  :uniqueness => {
	  	:scope => :psu,
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
	  #TODO: Add validations by strata or something

	validates :radius,
	  :presence => true,
	  :numericality => {
	  	:greater_than => 0,
	  }

	validates :psu_id,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true
	  }

	private

		def default_radius
			if self.radius.nil?
				self.radius = 7.5
			end
		end 
end
