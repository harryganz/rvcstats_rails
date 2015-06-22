class Domain < ActiveRecord::Base
  # Relationships
  has_many :strats

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
	  :inclusion => {
			:in => ['FLA KEYS', 'DRTO', 'SEFCRI']
		},
    :uniqueness => {
      :scope => [:year]
    }

  validates :richness,
    :allow_blank => true,
    :numericality => {
      :only_integer => true
    }
end
