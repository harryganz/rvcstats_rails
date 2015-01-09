module Api
	class YearsController < Api::BaseController
		# Define permitted params and query params
		private

		# Permitted modifiable params for year model 
		def year_params
			# None, read-only permissions for the API
			# I may make it writable when security is added
		end

		# Permitted query params for year model
		def query_params
			# All params are queriable for year
			params.permit(:id, :year)
		end
	end
end