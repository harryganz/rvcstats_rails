namespace :ntot do
  desc "migrates new strata to database"
  task migrate: :environment do
    puts 'starting to migrate strata'
    file = ENV['file'].to_s
    CSV.foreach(file, :headers => true) do |row|
      begin
        s = Strat.find_or_create_by(
          year: row['YEAR'].to_i,
          region: row['REGION'],
          strat: row['STRAT'],
          prot: row['PROT'].to_i,
          ntot: row['NTOT'].to_i,
          grid_size: row['GRID_SIZE'].to_i
        )
      rescue
        errors = s.errors.full_messages
        raise "Stratum Strat:#{s.strat}, Year:#{s.year}, "\
        "Region:#{s.region}, Prot:#{s.prot} not valid,"\
        " for the following reasons #{errors.each {|m| puts m}}"
      end
    end
    puts 'finished migrating strata'
  end

end
