json.array! @diversities do |d|
  json.YEAR d.strat.year
  json.REGION d.strat.region
  json.STRAT d.strat.strat
  json.PRIMARY_SAMPLE_UNIT d.primary_sample_unit
  json.STATION_NR d.station_nr
  json.RICHNESS d.richness
end
