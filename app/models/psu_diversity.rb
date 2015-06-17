class PsuDiversity < ActiveRecord::Base
  # Relations
  belongs_to :strat_diversity
  has_many :ssu_diversities

  # Validations
  validates :primary_sample_unit,
   :presence => true,
   :uniqueness => {
     :scope => [:strat_diversity_id],
     :message => 'must be unique within each stratum'
   }

  validates :strat_diversity_id,
    :presence => true,
    :numericality => {
      :only_integer => true
    }

  validates :richness,
    :presence => true,
    :numericality => {
      :only_integer => true
    }
end
