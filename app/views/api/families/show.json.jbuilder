json.family do
	json.id @family.id
	json.family_name @family.family_name
	json.common_name @family.common_name ? @family.common_name : nil
	json.genera @family.genera do |g|
		json.genus_name g.genus_name
	end
	json.species @family.species do |s|
		json.species_cd s.species_cd
		json.genus_name s.genus.genus_name
		json.species_name s.species_name
		json.common_name s.common_name ? s.common_name : nil
	end
end
