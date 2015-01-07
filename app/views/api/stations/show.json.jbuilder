json.station do
	json.id @station.id
	json.year @station.psu.stratum.year.year
	json.region_cd @station.psu.stratum.region.region_cd
	json.strat_cd @station.psu.stratum.strat_cd
	json.protected @station.psu.stratum.protected
	json.psu_cd @station.psu.psu_cd
	json.station_nr  @station.station_nr
	json.lat_degrees @station.lat_degrees
	json.lon_degrees @station.lon_degrees
	json.depth @station.depth
	json.underwater_visibility @station.underwater_visibility
	json.habitat_cd @station.habitat_cd
	json.radius @station.radius
end