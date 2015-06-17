require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }', { name: 'Copenhagen' }'])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Seeding database with data"
# Seed species data
puts "seeding taxonomic data"
Animal.delete_all
Animal.connection.execute( 'ALTER SEQUENCE animals_id_seq RESTART WITH 1' ) # Restart id numbering
ENV['file'] = "#{Rails.root}/db/seed_data/RVC_Species_List.csv"
# Invoke rake task in lib/tasks
Rake::Task['species:migrate'].invoke
puts "finished seeding taxonomic data"

#Seed life history data
puts "seeding life history data"
Parameter.delete_all
Parameter.connection.execute( 'ALTER SEQUENCE parameters_id_seq RESTART WITH 1')
ENV['file'] = "#{Rails.root}/db/seed_data/RVC_Lhp.csv"
Rake::Task['lh:migrate'].invoke
puts "finished seeding life history data"

# Seed stratum data
puts "seeding stratum data"
Strat.delete_all
Strat.connection.execute( 'ALTER SEQUENCE strats_id_seq RESTART WITH 1' ) #Restart id numbering
# Path to the directory containing stratum files
stratum_dir = "#{Rails.root}/db/seed_data/stratum_data"
# Array of filenames of stratum data
stratum_files = Dir.glob("#{stratum_dir}/**/*.csv")
# For each stratum file, run ntot:migrate task
stratum_files.each do |f|
  puts "migrating #{f}"
  ENV['file'] = f
  Rake::Task['ntot:migrate'].execute
end
puts "finished seeding stratum data"

# Seed Sample data
puts "seeding sample data"
Sample.delete_all
Sample.connection.execute('ALTER SEQUENCE samples_id_seq RESTART WITH 1' ) #Restart id numbering
# Path to the directory containing sample data
sample_dir = "#{Rails.root}/db/seed_data/sample_data"
# Array of filenames of sample data
sample_files = Dir.glob("#{sample_dir}/**/*.csv")
# For each sample file, run ar:migrate task
sample_files.each do |f|
  puts "migrating #{f}"
  ENV['file'] = f
  Rake::Task['ar:migrate'].execute
end
puts "Finished seeding sample data"

# Seed Diversity Data
puts "Seeding Diversity Data"
Diverity.delete_all
Diversity.connection.execute('ALTER SEQUENCE diversities_id_seq RESTART WITH 1')
# Unique year and region combinations
input_vars = Strat.all.pluck(:year, :region).uniq
# For each unique year and region, generate diverity data
input_vars.each do |i|
  ENV['YEAR'] = i[0]
  ENV['REGION'] = i[1]
  Rake::Task['diversity:generate'].execute
end

puts "completed seeding database with data"
