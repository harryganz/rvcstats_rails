require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }', { name: 'Copenhagen' }'])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Seeding database with data"

puts "Starting to seed animals table"
Animal.delete_all
Animal.connection.execute( 'ALTER SEQUENCE animals_id_seq RESTART WITH 1' ) # Restart id numbering
CSV.foreach("#{Rails.root}/db/seed_data/RVC_Species_List.csv") do |row|
	a = Animal.new(
		species_cd: row[0],
		sciname: row[1],
		comname: row[2]
		)
	if a.valid?
		a.save
	else
		errors = a.errors.full_messages
		raise "Species #{a.species_cd} not valid, for the following reasons #{errors.each {|m| puts m}}"
	end
end
puts "Finished seeding animals table"

puts "Starting to seed strats table"
Strat.delete_all
Strat.connection.execute( 'ALTER SEQUENCE strats_id_seq RESTART WITH 1' ) #Restart id numbering
CSV.foreach("#{Rails.root}/db/seed_data/RVC_Strat_List.csv") do |row|
	s = Strat.new(
		year: row[0].to_i,
		region: row[1],
		strat: row[2],
		prot: row[3].to_i,
		ntot: row[4].to_i,
		grid_size: row[5].to_i
	)
	if s.valid?
		s.save
	else
    errors = s.errors.full_messages
		raise "Stratum Strat:#{s.strat}, Year:#{s.year}, "\
		"Region:#{s.region}, Prot:#{s.prot} not valid,"\
		" for the following reasons #{errors.each {|m| puts m}}"
	end
end
puts "Finished seeding strats table"

puts "Starting to seed samples table"
Sample.connection.execute('ALTER SEQUENCE samples_id_seq RESTART WITH 1' ) #Restart id numbering
l = CSV.read("#{Rails.root}/db/seed_data/ar_2012.csv").length
n = 0
t = Time.now
# Set up all connections beforehand
animal_conn = Animal.connection
strat_conn = Strat.connection
sample_conn = Sample.connection
CSV.foreach("#{Rails.root}/db/seed_data/ar_2012.csv", :headers => true) do |row|
	# Query animals and strats for relavent IDs
 animal_id = animal_conn.execute(
 	"SELECT id FROM animals WHERE species_cd = '#{row['SPECIES_CD']}'"
 	).getvalue(0,0)
 strat_id = strat_conn.execute(
			"SELECT id FROM strats WHERE year = '#{row['YEAR']}'"\
			" AND region = '#{row['REGION']}'"\
			" AND strat = '#{row['STRAT']}'"\
			" AND prot = '#{row['PROT'].to_i}'"
			).getvalue(0,0)
# Execute insert statement
 sample_conn.execute(
 	"INSERT INTO samples VALUES('#{n}', '#{row['MONTH']}', '#{row['DAY']}', "\
 		"'#{row['PRIMARY_SAMPLE_UNIT']}', '#{row['ZONE_NR']}', '#{row['SUBREGION_NR']}',"\
 		"'#{row['MAPGRID_NR']}',  '#{row['MPA_NR']}', '#{row['TIME_SEEN']}', '#{row['STATION_NR']}',"\
 		"'#{row['LAT_DEGREES']}', '#{row['LON_DEGREES']}', '#{row['DEPTH']}',"\
 		"'#{row['UNDERWATER_VISIBILITY']}', '#{row['HABITAT_CD']}', '#{row['NUM']}',"\
 		"'#{row['LEN']}', '#{animal_id}', '#{strat_id}', '#{Time.now}', '#{Time.now}')"
 	)
# Track progress
 n += 1
 if n % (l/20) == 0
 	puts "#{(n.to_f/l * 100).ceil} percent complete"
 	puts "ET: #{(Time.now - t).round(3)} seconds"
 end
end
puts "finished seeding samples table"
