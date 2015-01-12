require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Seeding database with data"

# puts "Starting to seed animals table"
# Animal.delete_all
# Animal.connection.execute( 'ALTER SEQUENCE animals_id_seq RESTART WITH 1' ) # Restart id numbering
# CSV.foreach("#{Rails.root}/db/seed_data/RVC_Species_List.csv") do |row|
# 	a = Animal.new(
# 		species_cd: row[0],
# 		sciname: row[1],
# 		comname: row[2]
# 		)
# 	if a.valid?
# 		a.save
# 	else
# 		errors = a.errors.full_messages
# 		raise "Species #{a.species_cd} not valid, for the following reasons #{errors.each {|m| puts m}}"
# 	end
# end
# puts "Finished seeding animals table"

# puts "Starting to seed strats table"
# Strat.delete_all
# Strat.connection.execute( 'ALTER SEQUENCE strats_id_seq RESTART WITH 1' ) #Restart id numbering
# CSV.foreach("#{Rails.root}/db/seed_data/RVC_Strat_List.csv") do |row|
# 	s = Strat.new(
# 		year: row[0].to_i,
# 		region: row[1],
# 		strat: row[2],
# 		prot: row[3].to_i,
# 		ntot: row[4].to_i,
# 		grid_size: row[5].to_i
# 	)
# 	if s.valid?
# 		s.save
# 	else
#     errors = s.errors.full_messages
# 		raise "Stratum Strat:#{s.strat}, Year:#{s.year}, Region:#{s.region}, Prot:#{s.prot} not valid, for the following reasons #{errors.each {|m| puts m}}"
# 	end
# end
# puts "Finished seeding strats table"

puts "Starting to seed samples table"
Sample.connection.execute('ALTER SEQUENCE samples_id_seq RESTART WITH 1' ) #Restart id numbering
# Caching for faster performance
year = nil
region = nil
prot = nil
strat = nil
strat_id = nil
# Keep a count for percent complete output
l = CSV.read("#{Rails.root}/db/seed_data/AR_2012.csv").length
n = 0
CSV.foreach("#{Rails.root}/db/seed_data/ar_2012.csv", :headers => true) do |row|
	# Check cache
	unless row['YEAR'].to_i == year && row['REGION'] == region && row['STRAT'] == strat && row['MPA_NR'].to_i > 0 ? 1 : 0 == prot
		year = row['YEAR'].to_i
		region = row['REGION']
		prot = row['MPA_NR'].to_i > 0 ? 1 : 0
		strat = row['STRAT']
	end
	# Set the local animal and stratum variables
	animal = Animal.where(species_cd: row['SPECIES_CD']).take
	stratum = Strat.where(
		:year => year,
		:region => region,
		:prot => prot,
		:strat => strat 
		).take
	# Make sure they are not nil
	if animal.nil?
		raise "could not find species with species code #{row['SPECIES_CD']}"
	end
	if stratum.nil?
		raise "could not find stratum with year #{year}, stratum #{strat}, region #{region}, and protected status #{prot}"
	end
	s = Sample.new(
		month: row['MONTH'].to_i,
		day: row['DAY'].to_i,
		primary_sample_unit: row['PRIMARY_SAMPLE_UNIT'],
		zone_nr: row['ZONE_NR'].to_i,
		subregion_nr: row['SUBREGION_NR'].to_i,
		mapgrid_nr: row['MAPGRID_NR'].to_i,
		mpa_nr: row['MPA_NR'].to_i,
		time_seen: row['TIME_SEEN'].to_i,
		station_nr: row['STATION_NR'].to_i,
		lat_degrees: row['LAT_DEGREES'].to_f,
		lon_degrees: row['LON_DEGREES'].to_f,
		depth: row['DEPTH'].to_f,
		underwater_visibility: row['UNDERWATER_VISIBILITY'].to_f,
		habitat_cd: row['HABITAT_CD'],
		num: row['NUM'].to_f,
		len: row['LEN'].to_f,
		animal_id: animal.id,
		strat_id: stratum.id
		)
	if s.valid?
		s.save
	else
		errors = s.errors.full_messages
		raise "Sample Id:#{s.inspect} not valid for the following resons, #{errors.each {|m| puts m}}"
	end
	n += 1
	if n % (l/20).floor == 0 
		puts "#{(n.to_f/l * 100).ceil} percent complete"
	end
end
puts "finished seeding samples table"
