json.records @records do |r|
	json.id r.id
	json.species_cd r.animal.species_cd
	json.year r.station.psu.stratum.year.year
	json.region_cd r.station.psu.stratum.region.region_cd
 	json.strat_cd r.station.psu.stratum.strat_cd
 	json.protected r.station.psu.stratum.protected
 	json.psu_cd r.station.psu.psu_cd
 	json.station_nr r.station.station_nr
end