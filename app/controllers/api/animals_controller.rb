module Api

	class AnimalsController < Api::BaseController
		# Define permitted params and query params
		private

		# Permitted modifiable params for animal model 
		def animal_params
			# None, read-only permissions for the API
			# I may make it writable when security is added
		end

		# Permitted query params for animal model
		def query_params
			# All params are queriable for animal
			params.permit(:id, :species_name, :common_name, :species_cd,
				:species_nr, :gen_id)
		end
	end
end