class Diversity < ActiveRecord::Base
  has_many :samples
  belongs_to :strat

  #Validations
  validates :primary_sample_unit,
    :presence => :true

  validates :station_nr,
    :presence => :true,
    :uniqueness => {
      :scope => [:primary_sample_unit],
      :message => 'station_nr cannot be duplicated within a PSU'
      }

    validates :richness,
      :presence => :true,
      :numericality => :true

    validates :strat_id,
      :presence => true,
      :numericality => {
        :only_integer => true
      }
end
