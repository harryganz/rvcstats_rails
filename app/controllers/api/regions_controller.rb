module Api
	class RegionsController < Api::BaseController
		# Define permitted params and query params
		private

		# Permitted modifiable params for region model 
		def region_params
			# None, read-only permissions for the API
			# I may make it writable when security is added
		end

		# Permitted query params for region model
		def query_params
			# All params are queriable for region
			params.permit(:id, :region_name, :region_cd, :region_nr)
		end
	end
end