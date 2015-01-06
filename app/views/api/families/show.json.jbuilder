json.family do
	json.id @family.id
	json.family_name @family.family_name
	json.common_name @family.common_name ? @family.common_name : nil
	json.genera @family.genera do |g|
		json.genus_name g.genus_name
	end
# TODO: Add species hash for family, hint: use scopes
end
