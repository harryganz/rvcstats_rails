class Diversity < ActiveRecord::Base
  has_many :samples
  belongs_to :strat
end
