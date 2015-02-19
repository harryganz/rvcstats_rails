require 'csv'

namespace :ar do
  desc "migrates new AR data from csv file"
  task migrate: :environment do
    file = ENV['file'].to_s #get the file path from the environment
    conn = CSV.read(file, :headers => true)
    # Set up loop variables
    id = Sample.first.nil? ? 1 : Sample.last.id+1
    l = conn.length #number of rows in csv
    n = 1
    t = Time.now
    # Set up all connections beforehand
    animal_conn = Animal.connection
    strat_conn = Strat.connection
    sample_conn = Sample.connection
    # Check for duplicates
    year = conn["YEAR"][1]
    region = conn["REGION"][1]
    strat = Strat.where(:year => year, :region => region).first
    unless strat.present? & strat.samples.empty?
      raise "Samples from year:#{year} and region:#{region}"\
       " already found in database"
    end
    # Start loop
    puts "started migrating new samples"
    CSV.foreach(file, :headers => true) do |row|
      # Query animals and strats for relevant IDs
      begin
        animal_id = animal_conn.execute(
        "SELECT id FROM animals WHERE species_cd = '#{row['SPECIES_CD']}'"
        ).getvalue(0,0)
      rescue
        raise "species with species_cd: #{row['SPECIES_CD']} not found "\
        "in database, please add it and try again"
      end
      begin
        strat_id = strat_conn.execute(
        "SELECT id FROM strats WHERE year = '#{row['YEAR']}'"\
        " AND region = '#{row['REGION']}'"\
        " AND strat = '#{row['STRAT']}'"\
        " AND prot = '#{row['PROT'].to_i}'"
        ).getvalue(0,0)
      rescue
        raise "stratum with year: #{row['YEAR']}, region: #{row['REGION']},"\
        " strat: #{row['STRAT']}, and prot: #{row['PROT']} not found "\
        "in database, please add it and try again"
      end
      # Execute insert statement
      sample_conn.execute(
      "INSERT INTO samples VALUES('#{id}', '#{row['MONTH']}', '#{row['DAY']}', "\
      "'#{row['PRIMARY_SAMPLE_UNIT']}', '#{row['ZONE_NR']}', '#{row['SUBREGION_NR']}',"\
      "'#{row['MAPGRID_NR']}',  '#{row['MPA_NR']}', '#{row['TIME_SEEN']}', '#{row['STATION_NR']}',"\
      "'#{row['LAT_DEGREES']}', '#{row['LON_DEGREES']}', '#{row['DEPTH']}',"\
      "'#{row['UNDERWATER_VISIBILITY']}', '#{row['HABITAT_CD']}', '#{row['NUM']}',"\
      "'#{row['LEN']}', '#{animal_id}', '#{strat_id}', '#{Time.now}', '#{Time.now}')"
      )
      # Track progress
      if n % (l/20) == 0
        puts "#{(n.to_f/l * 100).ceil} percent complete"
        puts "ET: #{(Time.now - t).round(3)} seconds"
      end
      n += 1 #increment counter
      id += 1 #increment id
    end
    puts "finished migrating new samples"
  end
end
