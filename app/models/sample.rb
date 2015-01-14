class Sample < ActiveRecord::Base
	#Relationships 
	belongs_to :stratum, :class_name => 'Strat', :foreign_key => 'strat_id' 
	belongs_to :species, :class_name => 'Animal', :foreign_key => 'animal_id'

	#Validations
	CD_REGEX = /\A[A-Z]{3}\s{1}(?:[A-Z]{4}|[A-Z]{3}[.]{1})\Z/

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

	validates :primary_sample_unit, 
	  :presence => true

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

	validates :num,
	  :presence => true,
	  :numericality => {
	  	:greater_than_or_equal_to => 0
	  }

	validates :len,
	  :presence => true,
	  :numericality => true

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
	# TODO: Write a validation to detect duplicates

	# Scopes and Methods
	scope :with_species, -> species {joins(:species).where(:animals => {species_cd: species}) if species.present?}
	scope :with_year, -> year {joins(:stratum).where(:strats => {year: year}) if year.present?}
	scope :with_region, -> region {joins(:stratum).where(:strats => {region: region}) if region.present?}
	scope :with_stratum, -> stratum {joins(:stratum).where(:strats => {strat: stratum}) if stratum.present?}
	scope :is_protected, -> prot {joins(:stratum).where(:strats => {prot: prot}) if prot.present?}
	scope :when_present, -> p {where('samples.num > ?', p == 1 ? 0 : -1) if p.present?}
end
