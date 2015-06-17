class StratDiversity < ActiveRecord::Base
  # Relations
  belongs_to :domain_diversities
  belongs_to :strat
  has_many :psu_diversities

  # Validations
  validates :domain_diversity_id,
    :presence => true,
    :numericality => {
      :only_integer => true
    }

  validates :strat_id,
    :presence => true,
    :numericality => {
      :only_integer => true
    },
    :uniqueness => true

  validates :richness,
    :presence => true,
    :numericality => {
      :only_integer => true
    }
end
