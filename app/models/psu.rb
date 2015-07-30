class Psu < ActiveRecord::Base
  # Relationships
  belongs_to :strat
  has_many :ssus, dependent: :destroy

  # Validations
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
	  :presence => true,
    :uniqueness => {
      :scope => [:strat_id]
    }

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

  validates :richness,
    :allow_blank => true,
    :numericality => {
      :only_integer => true
    }

  validates :strat_id,
      :presence => true,
      :numericality => {
        :only_integer => true
      }
  # Methods and scopes
  def samples
    Sample.joins(ssu: :psu).where(psus: {id: id})
  end
end
