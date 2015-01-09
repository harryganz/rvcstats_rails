json.array! @records do |r|
	json.ID r.id
	json.SPECIES_CD r.animal.species_cd
	json.YEAR r.station.psu.stratum.year.year
	json.REGION r.station.psu.stratum.region.region_cd
 	json.STRAT r.station.psu.stratum.strat_cd
 	json.MPA_NR r.station.psu.mpa_nr
 	json.PRIMARY_SAMPLE_UNIT r.station.psu.psu_cd
 	json.STATION_NR r.station.station_nr
 	json.NUM r.num
 	json.LEN r.len
end