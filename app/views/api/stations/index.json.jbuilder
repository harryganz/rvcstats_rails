json.stations @stations do |s|
	json.id s.id
	json.year s.psu.stratum.year.year
	json.region_cd s.psu.stratum.region.region_cd
	json.strat_cd s.psu.stratum.strat_cd
	json.protected s.psu.stratum.protected
	json.psu_cd s.psu.psu_cd
	json.station_nr s.station_nr
end