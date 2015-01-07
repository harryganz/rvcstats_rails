module Api

	class RecordsController < Api::BaseController
		# Define permitted params and query params
		private

		# Permitted modifiable params for record model 
		def record_params
			# None, read-only permissions for the API
			# I may make it writable when security is added
		end

		# Permitted query params for record model
		def query_params
			# All params are queriable for record
			params.permit(:id, :num, :len, :time_seen, :station_id, 
				:animal_id)
		end
	end
end