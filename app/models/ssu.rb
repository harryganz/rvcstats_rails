class Ssu < ActiveRecord::Base
  # Relationships
  belongs_to :psu
  has_many :samples

  # Validations
  validates :station_nr,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true,
	  	:greater_than => 0,
	  	:less_than => 11
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

  validates :richness,
    :allow_blank => true,
    :numericality => {
      :only_integer => true
    }

  validates :psu_id,
    :presence => true,
    :numericality => {
      :only_integer => true
    }
end
