class DomainDiversity < ActiveRecord::Base
  # Relations
  has_many :strat_diversities

  # Validations
  validates :year,
	:presence => true,
	:numericality => {
		:greater_than => 1993,
		:less_than_or_equal_to => Time.now.year,
		:message => 'must be between 1994 and the current year'
	}

  validates :region,
	  :presence => true,
    :uniqueness => {
      :scope => [:year],
      :message => 'must be unique for each year'
    },
	  :inclusion => {
			:in => ['FLA KEYS', 'DRTO', 'SEFCRI']
		}

  validates :richness,
    :presence => true,
    :numericality => {
      :only_integer => true
    }

end
