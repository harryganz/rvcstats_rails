json.id @strat.id
json.records @strat.psus.each do |psu|
	psu.stations.each do |station|
		station.records.each do |record|
			json.record_id record.id
		end
	end
end