json.psus @psus do |p|
	json.region_cd p.region.region_cd
	json.year p.year.year
	json.month p.month
	json.day p.day
	json.strat_cd p.stratum.strat_cd
	json.psu_cd p.psu_cd
	json.mpa_nr p.mpa_nr
end
