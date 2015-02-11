require 'csv'
namespace :species do
  desc "migrates new species to database from csv file"
  task migrate: :environment do
    puts "starting to add species"
    file = ENV['file'].to_s
    CSV.foreach(file, :headers => true) do |row|
      begin
        a = Animal.find_or_create_by(
        species_cd: row['SPECIES_CD'],
        sciname: row['SCINAME'],
        comname: row['COMNAME']
        )
      rescue
        errors = a.errors.full_messages
        raise "Species #{a.species_cd} not valid, "\
        "for the following reasons #{errors.each {|m| puts m}}"
      end
    end
    puts "finished adding species"
  end
end
