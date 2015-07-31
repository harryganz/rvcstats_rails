json.array! @ssus do |s|
  json.YEAR s.year
  json.REGION s.region
  json.STRAT s.strat
  json.PROT s.prot
  json.PRIMARY_SAMPLE_UNIT s.primary_sample_unit
  json.STATION_NR s.station_nr
  json.MAX_HARD_RELIEF s.max_hard_relief
  json.MAX_SOFT_RELIEF s.max_soft_relief
  json.AVG_HARD_RELIEF s.avg_hard_relief
  json.HARD_REL_PCT_0 s.hard_rel_pct_0
  json.HARD_REL_PCT_1 s.hard_rel_pct_1
  json.HARD_REL_PCT_2 s.hard_rel_pct_2
  json.HARD_REL_PCT_3 s.hard_rel_pct_3
  json.HARD_REL_PCT_4 s.hard_rel_pct_4
  json.PCT_SAND s.pct_sand
  json.PCT_HARD_BOTTOM s.pct_hard_bottom
  json.PCT_CORAL s.pct_coral
  json.PCT_OCTO s.pct_octo
  json.PCT_SPONGE s.pct_sponge
  json.PCT_RUBBLE s.pct_rubble
end
