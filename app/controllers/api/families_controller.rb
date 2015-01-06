module Api

	class FamiliesController < Api::BaseController
		# Define permitted params and query params
		private

		# Permitted modifiable params for family model 
		def family_params
			# None, read-only permissions for the API
			# I may make it writable when security is added
		end

		# Permitted query params for family model
		def query_params
			# All params are queriable for family
			params.permit(:id, :family_name, :common_name,
				:family_nr)
		end
	end
end