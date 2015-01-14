json.array! @samples do |s|
	json.YEAR s.stratum.year
	json.REGION s.stratum.region
	json.STRAT s.stratum.strat
	json.MPA_NR s.mpa_nr
	json.PRIMARY_SAMPLE_UNIT s.primary_sample_unit
	json.STATION_NR s.station_nr
	json.SPECIES_CD s.species.species_cd
	json.TIME_SEEN s.time_seen
	json.LEN s.len
	json.NUM s.num
end