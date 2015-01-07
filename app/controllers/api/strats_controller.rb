module Api

	class StratsController < Api::BaseController
		# Define permitted params and query params
		private

		# Permitted modifiable params for strat model 
		def strat_params
			# None, read-only permissions for the API
			# I may make it writable when security is added
		end

		# Permitted query params for strat model
		def query_params
			# All params are queriable for strat
			params.permit(:strat_cd, :strat_description,
				:protected, :ntot, :grid_size, :year_id, :region_id)
		end
	end 
end