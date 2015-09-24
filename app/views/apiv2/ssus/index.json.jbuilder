json.ssus @ssus do |ss|
  json.id ss.id
  json.station_nr ss.station_nr
  json.lat_degrees ss.lat_degrees
  json.lon_degrees ss.lon_degrees
  json.depth ss.depth
  json.underwater_visibility ss.underwater_visibility
  json.habitat_cd ss.habitat_cd
  json.richness ss.richness
  json.psu_id ss.psu_id
  json.max_hard_relief ss.max_hard_relief
  json.max_soft_relief ss.max_soft_relief
  json.avg_hard_relief ss.avg_hard_relief
  json.hard_rel_pct_0 ss.hard_rel_pct_0
  json.hard_rel_pct_1 ss.hard_rel_pct_1
  json.hard_rel_pct_2 ss.hard_rel_pct_2
  json.hard_rel_pct_3 ss.hard_rel_pct_3
  json.hard_rel_pct_4 ss.hard_rel_pct_4
  json.pct_sand ss.pct_sand
  json.pct_hard_bottom ss.pct_hard_bottom
  json.pct_rubble ss.pct_rubble
  json.pct_coral ss.pct_coral
  json.pct_octo ss.pct_octo
  json.pct_sponge ss.pct_sponge
end
