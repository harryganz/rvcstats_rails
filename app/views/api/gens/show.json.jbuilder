json.gen do
	json.id @gen.id
	json.genus_name @gen.genus_name
	json.family_name @gen.family.family_name
	json.common_name @gen.common_name ? @gen.common_name : nil
	json.species @gen.species do |s|
		json.species_cd s.species_cd
		json.species_name s.species_name
		json.common_name s.common_name
	end
end
