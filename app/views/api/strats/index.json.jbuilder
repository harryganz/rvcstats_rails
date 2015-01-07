json.strata @strats do |stratum|
	json.id stratum.id
	json.year stratum.year.year
	json.region_cd stratum.region.region_cd
	json.strat_cd stratum.strat_cd
	json.protected stratum.protected
end