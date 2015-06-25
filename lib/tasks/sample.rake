require 'csv'
namespace :sample do
  desc "migrates samples from csv file"
  task migrate: :environment do
    puts 'starting to migrate samples'
    file = ENV['file'].to_s
    # Set up connection to database
    conn = Domain.connection
    # Variables to track loop progress
    n = 0
    l = CSV.read(file).length
    t = Time.now
    # Loop through CSV and insert sample into samples table
    csv = CSV.foreach(file, :headers => true) do |r|
      # Get ssu_id
      ssu = conn.execute("SELECT ssus.id FROM ssus, psus, strats, domains "\
        "WHERE ssus.psu_id = psus.id AND psus.strat_id = strats.id "\
        "AND strats.domain_id = domains.id AND "\
        "domains.year = #{r["YEAR"]} AND domains.region = '#{r["REGION"]}' "\
        "AND strats.strat = '#{r["STRAT"]}' AND strats.prot = #{r["PROT"]}"\
        "AND psus.primary_sample_unit = '#{r["PRIMARY_SAMPLE_UNIT"]}' "\
        "AND ssus.station_nr = #{r["STATION_NR"]}")
      # Raise error if more or less than one matching SSU found
      if ssu.num_tuples != 1
        raise "more/less than 1 record found for sample with year: "\
          "#{r["YEAR"]}, region: #{r["REGION"]}, strat: #{r["STRAT"]}, "\
          "prot: #{r["PROT"]}, psu: #{r["PRIMARY_SAMPLE_UNIT"]}, and "\
          "station_nr: #{r["STATION_NR"]}"
       end
       # Look up animal_id from species code
       species = conn.execute("SELECT id FROM animals WHERE "\
         "species_cd = '#{r["SPECIES_CD"]}'")
       if species.num_tuples != 1
         raise "more/less than 1 animal found with the name: #{r["SPECIES_CD"]}"
       end
      # Insert sample into samples table
       conn.execute("INSERT INTO samples (ssu_id, num, len, time_seen, "\
       "animal_id, created_at, updated_at) VALUES (#{ssu[0]["id"].to_i},"\
       " #{r["NUM"]}, #{r["LEN"]}, #{r["TIME_SEEN"]},"\
       " #{species[0]["id"].to_i}, '#{Time.now}', '#{Time.now}')")
        # Track loop progress
        n += 1
        if n % (l.to_f/20).round == 0
          puts "#{(n.to_f/l * 100).round} percent complete"
          puts "ET: #{(Time.now - t).round} seconds elapsed"
        end
    end
    puts 'finished migrating samples'

  end
end
