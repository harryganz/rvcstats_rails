module Api

class PsusController < Api::BaseController
		# Define permitted params and query params
		private

		# Permitted modifiable params for psu model 
		def psu_params
			# None, read-only permissions for the API
			# I may make it writable when security is added
		end

		# Permitted query params for psu model
		def query_params
			# All params are queriable for psu
			params.permit(:id, :psu_cd, :month, :day, :zone_nr,
				:subregion_nr, :mapgrid_nr, :mpa_nr, :strat_id, :region_id,
				:year_id)
		end
	end
end