namespace :ntot do
  desc "migrates new strata to database"
  task migrate: :environment do
    puts 'starting to migrate strata'
    file = ENV['file'].to_s
    CSV.foreach(file, :headers => true) do |row|
      d = Domain.where(year: row['YEAR'], region: row['REGION']).first
      s = Strat.find_or_initialize_by(
        domain_id: d.id,
        strat: row['STRAT'],
        prot: row['PROT'].to_i,
        rugosity_cd: row['RUGOSITY_CD'].present? ? row['RUGOSITY_CD'].to_i : 0,
        rfhab: row['RFHAB'].present? ? row['RFHAB'] : row['STRAT']
      )
      s.assign_attributes(
        ntot: row['NTOT'].to_i,
        grid_size: row['GRID_SIZE'].to_i
      )
      if(s.valid?)
        s.save
      else
        errors = s.errors.full_messages
        raise "Stratum Strat:#{s.strat}, Year:#{s.year}, "\
        "Region:#{s.region}, Prot:#{s.prot} not valid,"\
        " for the following reasons #{errors.each {|m| puts m}}"
      end
    end
    puts 'finished migrating strata'
  end

end
