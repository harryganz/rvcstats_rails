json.id @region.id
json.records @region.strata do |stratum|
	json.stratum_id stratum.id
end