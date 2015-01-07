json.stratum do
	json.id @strat.id
	json.year @strat.year.year
	json.region_cd @strat.region.region_cd
	json.region_name @strat.region.region_name
	json.strat_cd @strat.strat_cd
	json.protected @strat.protected
	json.ntot @strat.ntot
	json.grid_size @strat.grid_size
end