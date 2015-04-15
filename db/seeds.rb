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
Animal.delete_all
Animal.connection.execute( 'ALTER SEQUENCE animals_id_seq RESTART WITH 1' ) # Restart id numbering
ENV['file'] = "#{Rails.root}/db/seed_data/RVC_Species_List.csv"
# Invoke rake task in lib/tasks
Rake::Task['species:migrate'].invoke

#Seed life history data
Parameter.delete_all
Parameter.connection.execute( 'ALTER SEQUENCE parameters_id_seq RESTART WITH 1')
ENV['file'] = "#{Rails.root}/db/seed_data/RVC_Lhp.csv"
Rake::Task['lh:migrate'].invoke

# Seed stratum data
Strat.delete_all
Strat.connection.execute( 'ALTER SEQUENCE strats_id_seq RESTART WITH 1' ) #Restart id numbering
ENV['file'] = "#{Rails.root}/db/seed_data/RVC_Strat_List.csv"
Rake::Task['ntot:migrate'].invoke

# Seed Sample data
Sample.delete_all
Sample.connection.execute('ALTER SEQUENCE samples_id_seq RESTART WITH 1' ) #Restart id numbering
puts "migrating 2012 data"
ENV['file'] = "#{Rails.root}/db/seed_data/fk2012_dat2.csv"
Rake::Task['ar:migrate'].invoke
puts "migrating 2011 data"
ENV['file'] = "#{Rails.root}/db/seed_data/fk2011_dat2.csv"
Rake::Task['ar:migrate'].invoke
puts "migrating 2010 data"
ENV['file'] = "#{Rails.root}/db/seed_data/fk2010_dat2.csv"
Rake::Task['ar:migrate'].invoke
puts "migrating 2009 data"
ENV['file'] = "#{Rails.root}/db/seed_data/fk2009_dat2.csv"
Rake::Task['ar:migrate'].invoke

puts "completed seeding database with data"
