json.array! @regions do |region|
	json.id region.id
	json.region_cd region.region_cd
	json.region_name region.region_name
	json.region_nr region.region_nr
end