json.array! @gens do |genus|
	json.id genus.id
	json.genus_name genus.genus_name
	json.common_name genus.common_name ? genus.common_name : nil
end
