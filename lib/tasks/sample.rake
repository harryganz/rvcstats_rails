require 'csv'
namespace :sample do
  desc "migrates samples from csv file"
  task migrate: :environment do
    puts 'starting to migrate samples'
    file = ENV['file'].to_s
    # Set up a connection to the samples table
    conn = Sample.connection
    # Variables to track loop progress
    n = 0
    l = CSV.read(file).length
    t = Time.now
    # Declare loop variables
    ssu_id = nil
    animal_id = nil
    # Cached copies to reduce querying the database
    psu = nil
    ssu = nil
    # Loop through CSV and insert sample into samples table
    CSV.foreach(file, :headers => true) do |r|
      # Check that PSU and SSU have not changed since previous rows
      # Warning: does not check for changes in year/region and
      # can return invalid data if year changes between rows and
      # but the PSU names are the same
      if (r["PRIMARY_SAMPLE_UNIT"] != psu || r["STATION_NR"] != ssu)
        # Get ssu_id
        ssu_id = conn.execute("SELECT ssus.id FROM ssus, psus, strats, domains "\
        " WHERE ssus.psu_id = psus.id AND psus.strat_id = strats.id AND "\
        " strats.domain_id = domains.id AND domains.region = '#{r["REGION"]}' AND "\
        " domains.year = #{r["YEAR"]} AND strats.strat = '#{r["STRAT"]}' AND "\
        " strats.prot = #{r["PROT"]} AND "\
        " psus.primary_sample_unit = '#{r["PRIMARY_SAMPLE_UNIT"]}' AND"\
        " ssus.station_nr = #{r["STATION_NR"]}")[0]["id"]
        if ssu_id.nil?
          raise "SSU not found for year: #{r["YEAR"]} region: #{r["REGION"]}"\
          " psu: #{r["PRIMARY_SAMPLE_UNIT"]} and station: #{r["STATION_NR"]}"
        end
        psu = r["PRIMARY_SAMPLE_UNIT"]
        ssu = r["STATION_NR"]
      end
      # Get animal_id
      animal_id = conn.execute("SELECT id FROM animals WHERE"\
      " species_cd = '#{r["SPECIES_CD"]}'")[0]["id"]
      if animal_id.nil?
        raise "No species found with the SPECIES_CD: '#{r["SPECIES_CD"]}'"
      end
      # Insert into samples
      conn.execute("INSERT INTO samples (num, len, time_seen, animal_id, "\
      " ssu_id, created_at, updated_at) VALUES (#{r["NUM"]}, #{r["LEN"]}, "\
      " #{r["TIME_SEEN"]}, #{animal_id}, #{ssu_id}, '#{Time.now}',"\
      " '#{Time.now}')")
        n += 1
        if n % (l.to_f/20).round == 0
          puts "#{(n.to_f/l * 100).round} percent complete"
          puts "ET: #{(Time.now - t).round} seconds elapsed"
        end
    end
    puts 'finished migrating samples'
  end
end
