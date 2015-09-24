json.array! @psus do |p|
  json.id p.id
  json.month p.month
  json.day p.day
  json.primary_sample_unit p.primary_sample_unit
  json.subregion_nr p.subregion_nr
  json.mpa_nr p.mpa_nr
  json.richness p.richness
  json.strat_id p.strat_id
  json.m p.m
end
