json.array! @domains do |d|
  json.id d.id
  json.year d.year
  json.region d.region
  json.richness d.richness
  json.strata d.strats do |st|
    json.id st.id
    json.strat st.strat
    json.prot st.prot
    json.ntot st.ntot
    json.grid_size st.grid_size
    json.richness st.richness
    json.domain_id st.domain_id
    json.rfhab st.rfhab
    json.rugosity_cd st.rugosity_cd
    json.nm st.nm
    json.n st.n
    json.psus st.psus do |p|
      json.id p.id
      json.month p.month
      json.day p.day
      json.primary_sample_unit p.primary_sample_unit
      json.subregion_nr p.subregion_nr
      json.mpa_nr p.mpa_nr
      json.richness p.richness
      json.strat_id p.strat_id
      json.m p.m
      json.ssus p.ssus do |ss|
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
        json.samples ss.samples do |sa|
          json.id sa.id
          json.animal_id sa.animal_id
          json.time_seen sa.time_seen
          json.num sa.num
          json.len sa.len
          json.ssu_id sa.ssu_id
        end
      end
    end
  end
end
