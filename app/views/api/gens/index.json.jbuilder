json.gen @gens do |genus|
	json.id genus.id
	json.family_name genus.family.family_name
	json.genus_name genus.genus_name
	json.common_name genus.common_name ? genus.common_name : nil
end
