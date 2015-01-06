json.animals @animals do |animal|
	json.species_cd animal.species_cd
	json.genus animal.genus.genus_name
	json.species animal.species_name
	json.common_name animal.common_name
end
