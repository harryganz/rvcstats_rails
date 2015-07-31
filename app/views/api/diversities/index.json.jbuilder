json.array! @ssu do |s|
  json.YEAR s.year
  json.REGION s.region
  json.STRAT s.strat
  json.NTOT s.psu.strat.ntot
  json.PROT s.prot
  json.PRIMARY_SAMPLE_UNIT s.primary_sample_unit
  json.GRID_SIZE s.psu.strat.grid_size
  json.STATION_NR s.station_nr
  json.DOMAIN_RICHNESS s.psu.strat.domain.richness
  json.STRAT_RICHNESS s.psu.strat.richness
  json.PSU_RICHNESS s.psu.richness
  json.SSU_RICHNESS s.richness
end
