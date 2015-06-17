class SsuDiversity < ActiveRecord::Base
  # Relations
  belongs_to :psu_diversity

  # Validations
  validates :station_nr,
    :presence => true,
    :numericality => {
      :only_integer => true
    },
    :uniqueness => {
      :scope => [:psu_diversity_id],
      :message => 'must be unique within each PSU'
    }

  validates :psu_diversity_id,
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
