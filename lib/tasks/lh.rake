namespace :lh do #start 1
  desc 'migrates new life history data from a csv file'
  task migrate: :environment do #start 2
    puts 'starting to migrate life history parameters'
    file = ENV['file'].to_s #get the file path from the environment
    CSV.foreach(file, :headers => true) do |row| #start 3
      begin #start 4
        a = Animal.find_by_species_cd(row['SPECIES_CD'])
        if a.nil?
          raise "Species #{row['SPECIES_CD']} not found in database"
        end
        p = Parameter.find_or_create_by!(
          animal_id: a.id,
          length_at_capture: (row['LC'].nil? ? nil : row['LC'].to_f),
          length_at_maturity: (row['LM'].nil? ? nil : row['LM'].to_f),
          wlen_a: (row['WLEN_A'].nil? ? nil : row['WLEN_A'].to_f),
          wlen_b: (row['WLEN_B'].nil? ? nil : row['WLEN_B'].to_f)
        )
      rescue
        errors = p.errors.full_messages
        raise "Life history parameters belonging to the "\
         "species #{row['SPECIES_CD']} could not be saved for the "\
         "following reasons #{errors.each {|m| puts m}}"
      end #end 4
    end #end 3
    puts 'finished migrating life history parameters'
  end #end 2

end #end 1
