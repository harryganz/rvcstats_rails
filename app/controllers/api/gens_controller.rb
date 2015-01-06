module Api

	class GensController < Api::BaseController
		# Define permitted params and query params
		private

		# Permitted modifiable params for  model 
		def gen_params
			# None, read-only permissions for the API
			# I may make it writable when security is added
		end

		# Permitted query params for gen model
		def query_params
			# All params are queriable for gen
			params.permit(:id, :genus_name, :common_name,
				:family_id)
		end
	end
end