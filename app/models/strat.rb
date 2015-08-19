class Strat < ActiveRecord::Base
	#Relationships
	belongs_to :domain
	has_many :psus, dependent: :destroy

	#Validations
	validates :strat,
	  :presence => true,
	  :uniqueness => {
	  	:scope => [:domain_id, :prot],
	  	:message => 'must be unique for each combination of
	  	year, region, and protected status'
	  }

	validates :prot,
		:numericality => true,
	  :inclusion => {
	  	:in => [0, 1, 2],
	  	:message => 'must be 0, 1 or 2'
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

	validates :rfhab,
	 :presence => true

	validates :rugosity_cd,
	 :presence => true,
	 :numericality => {
		:only_integer => true,
		:greater_than => -1,
		:less_than => 3
	}

	validates :richness,
    :allow_blank => true,
    :numericality => {
      :only_integer => true
    }

	validates :domain_id,
		:presence => true,
		:numericality => {
			:only_integer => true
		}

		# Methods and Scopes
		scope :with_year, -> year {includes(:domain).where(domains: {
			:year => year}) if year.present?}
		scope :with_region, -> region {includes(:domain).where(
			domains: {:region => region}
			) if region.present?}
		scope :with_strat, -> strat {where(strat: strat) if strat.present?}
		scope :with_prot, -> prot {where(prot: prot) if prot.present?}

		def year
			return domain.year
		end

		def region
			return domain.region
		end

		def samples
			Sample.joins(ssu: {psu: :strat}).where(strats: {id: id})
		end
end
