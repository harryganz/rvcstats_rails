json.array! @strats do |stratum|
	json.ID stratum.id
	json.YEAR stratum.year.year
	json.REGION stratum.region.region_cd
	json.STRAT stratum.strat_cd
	json.PROT stratum.protected ? 1 : 0 
	json.NTOT stratum.ntot
	json.GRID_SIZE stratum.grid_size
end