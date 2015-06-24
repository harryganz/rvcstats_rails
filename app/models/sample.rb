class Sample < ActiveRecord::Base
	#Relationships
	belongs_to :animal
	belongs_to :ssu

	#Validations
	validates :time_seen,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true
	  },
	  :inclusion => {:in => [1,2,3]}

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

	validates :ssu_id,
	  :presence => true,
	  :numericality => {
	  	:only_integer => true
	  }



	# Scopes and Methods
	 scope :with_species, -> species {joins(:animal).where(
		:animals => {species_cd: species}) if species.present?}
	 scope :with_year, -> year {joins(ssu: {psu: {strat: :domain}}).where(
		domains: {year: year.to_i}) if year.present?}
	 scope :with_region, -> region {joins(ssu: {psu: {strat: :domain}}).where(
		domains: {region: region}) if region.present?}
	 scope :with_stratum, -> stratum {joins(ssu: {psu: :strat}).where(
		:strats => {strat: stratum}) if stratum.present?}
	 scope :is_protected, -> prot {joins(ssu: {psu: :strat}).where(
		:strats => {prot: prot.to_i}) if prot.present?}
	 scope :when_present, -> p {
		where('num > ?', p.to_i == 1 ? 0 : -1) if p.present?}
	# Methods to create virtual attributes
	def mpa_nr
		return ssu.psu.mpa_nr
	end

	def primary_sample_unit
		return ssu.psu.primary_sample_unit
	end

	def station_nr
		return ssu.psu.station_nr
	end

	def lat_degrees
		return ssu.lat_degrees
	end

	def lon_degrees
		return ssu.lon_degrees
	end

	def underwater_visibility
		return ssu.underwater_visibility
	end

	def depth
		return ssu.depth
	end
end
