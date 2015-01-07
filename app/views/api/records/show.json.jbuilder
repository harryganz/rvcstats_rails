json.record do
	json.id @record.id
	json.species_cd @record.animal.species_cd
	json.year @record.station.psu.stratum.year.year
	json.region_cd @record.station.psu.stratum.region.region_cd
 	json.strat_cd @record.station.psu.stratum.strat_cd
 	json.protected @record.station.psu.stratum.protected
 	json.psu_cd @record.station.psu.psu_cd
 	json.station_nr @record.station.station_nr
 	json.time_seen @record.time_seen
 	json.len @record.len
 	json.num @record.num
end