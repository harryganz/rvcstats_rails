require 'csv'

namespace lh: do
  desc 'migrates new life history data from a csv file'
  task migrate: :environment do
    file = ENV['file'].to_s #get the file path from the environment
    puts 'starting to migrate life history parameters'
    CSV.foreach(file, :headers => true) do |row|
      begin
        a = Animal.find_by_species_cd(row['SPECIES_CD'])
         #Raises error if not found
        p = Parameter.find_or_create_by(
          animal_id: a.id,
          length_at_capture: row['LC'].to_f,
          length_at_maturity: row['LM'].to_f,
          wlen_a: row['WLEN_A'].to_f,
          wlen_b: row['WLEN_B'].to_f
        )
      rescue
        errors = p.errors.full_messages
        raise "Life history parameters belonging to the "\
         "species #{row['SPECIES_CD']} could not be saved for the "\
         "following reasons #{errors.each {|m| puts m}}"
      end
    end
    puts 'finished migrating life history parameters'
  end
end
