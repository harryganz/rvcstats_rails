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
	 scope :with_species, -> species {includes(:animal).where(
		:animals => {species_cd: species}) if species.present?}
	 scope :with_year, -> year {includes(ssu: {psu: {strat: :domain}}).where(
		domains: {year: year}) if year.present?}
	 scope :with_region, -> region {includes(ssu: {psu: {strat: :domain}}).where(
		domains: {region: region}) if region.present?}
	 scope :with_stratum, -> stratum {includes(ssu: {psu: :strat}).where(
		:strats => {strat: stratum}) if stratum.present?}
	 scope :is_protected, -> prot {includes(ssu: {psu: :strat}).where(
		:strats => {prot: prot.to_i}) if prot.present?}
	 scope :when_present, -> p {
		where('num > ?', p.to_i == 1 ? 0 : -1) if p.present?}

	# Methods to create virtual attributes
	def year
		return ssu.psu.strat.domain.year
	end

	def region
		return ssu.psu.strat.domain.region
	end

	def strat
		return ssu.psu.strat.strat
	end

	def prot
		return ssu.psu.strat.prot
	end

	def mpa_nr
		return ssu.psu.mpa_nr
	end

	def primary_sample_unit
		return ssu.psu.primary_sample_unit
	end

	def station_nr
		return ssu.station_nr
	end

	def lat_degrees
		return ssu.lat_degrees
	end

	def lon_degrees
		return ssu.lon_degrees
	end

	def species_cd
		return animal.species_cd
	end

	def underwater_visibility
		return ssu.underwater_visibility
	end

	def depth
		return ssu.depth
	end
end
