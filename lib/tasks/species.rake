require 'csv'
namespace :species do
  desc "migrates new species to database from csv file"
  task migrate: :environment do
    puts "starting to migrate species"
    file = ENV['file'].to_s
    CSV.foreach(file, :headers => true) do |row|
      a = Animal.find_or_initialize_by(
        species_cd: row['SPECIES_CD']
      )
      a.assign_attributes(
        sciname: row['SCINAME'],
        comname: row['COMNAME']
      )
      if a.valid?
        a.save
      else
        errors = a.errors.full_messages
        raise "Species #{a.species_cd} not valid, "\
        "for the following reasons #{errors.each {|m| puts m}}"
      end
    end
    puts "finished migrating species"
  end
end
