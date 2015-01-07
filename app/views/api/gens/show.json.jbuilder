json.gen do
	json.id @gen.id
	json.genus_name @gen.genus_name
	json.family_name @gen.family.family_name
	json.common_name @gen.common_name ? @gen.common_name : nil
end
