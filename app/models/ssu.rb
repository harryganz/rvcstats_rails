class Ssu < ActiveRecord::Base
  # Relationships
  belongs_to :psu
  has_many :samples, dependent: :destroy

  # Validations
  validates :station_nr,
	  :presence => true,
    :uniqueness => {
      :scope => [:psu_id]
    },
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

  validates :max_hard_relief,
    :allow_blank => true,
    :numericality => {
      :greater_than_or_equal_to => 0
    }

  validates :max_soft_relief,
    :allow_blank => true,
    :numericality => {
      :greater_than_or_equal_to => 0
    }

  validates :avg_hard_relief,
  :allow_blank => true,
  :numericality => {
    :greater_than_or_equal_to => 0
  }

  validates :hard_rel_pct_0,
    :allow_blank => true,
    :numericality => {
      :greater_than_or_equal_to => 0,
      :less_than_or_equal_to => 100
    }

  validates :hard_rel_pct_1,
    :allow_blank => true,
    :numericality => {
      :greater_than_or_equal_to => 0,
      :less_than_or_equal_to => 100
    }

  validates :hard_rel_pct_2,
    :allow_blank => true,
    :numericality => {
      :greater_than_or_equal_to => 0,
      :less_than_or_equal_to => 100
    }

  validates :hard_rel_pct_3,
    :allow_blank => true,
    :numericality => {
      :greater_than_or_equal_to => 0,
      :less_than_or_equal_to => 100
    }

  validates :hard_rel_pct_4,
    :allow_blank => true,
    :numericality => {
      :greater_than_or_equal_to => 0,
      :less_than_or_equal_to => 100
    }

  validates :pct_sand,
  :allow_blank => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  validates :pct_hard_bottom,
  :allow_blank => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  validates :pct_coral,
  :allow_blank => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  validates :pct_octo,
  :allow_blank => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  validates :pct_sponge,
  :allow_blank => true,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }

  # Methods and scopes
  scope :with_year, -> year {Ssu.includes(psu: {strat: :domain}).
   where(domains: {year: year}) if year.present?}
  scope :with_region, -> region {Ssu.includes(psu: {strat: :domain}).
   where(domains: {region: region}) if region.present?}
  scope :with_strat, -> strat {Ssu.includes(psu: :strat).
   where(strats: {strat: strat}) if strat.present?}

  def year
    psu.strat.domain.year
  end

  def region
    psu.strat.domain.region
  end

  def strat
    psu.strat.strat
  end

  def prot
    psu.strat.prot
  end

  def primary_sample_unit
    psu.primary_sample_unit
  end

end
