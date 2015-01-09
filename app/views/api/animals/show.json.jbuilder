json.id @animal.id
json.species_cd @animal.species_cd
json.genus_name @animal.genus.genus_name
json.genus_id @animal.genus_id
json.species_name @animal.species_name
json.common_name @animal.common_name ? @animal.common_name : nil