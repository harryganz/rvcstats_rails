module Api

	class StationsController < Api::BaseController
		# Define permitted params and query params
		private

		# Permitted modifiable params for station model 
		def station_params
			# None, read-only permissions for the API
			# I may make it writable when security is added
		end

		# Permitted query params for station model
		def query_params
			# All params are queriable for station
			params.permit(:id, :station_nr, :lat_degrees, :lon_degrees, 
				:depth, :underwater_visibility, :habitat_cd, :radius, :psu_id)
		end
	end
end