json.id @gen.id
json.species @gen.species do |s|
	json.species_id s.id
	json.species_cd
	json.species_name s.species_name
end
