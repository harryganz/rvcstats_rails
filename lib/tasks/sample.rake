require 'csv'
namespace :sample do
  desc "migrates samples from csv file"
  task migrate: :environment do
    puts 'starting to migrate samples'
    file = ENV['file'].to_s
    # Set up a connection to the samples table
    conn = Sample.connection
    # Set up table to query for SSU
    ssu_table = Ssu.includes(psu: {strat: :domain})
    # Variables to track loop progress
    n = 0
    l = CSV.read(file).length
    t = Time.now
    # Loop through CSV and insert sample into samples table
    CSV.foreach(file, :headers => true) do |r|
      # Get ssu_id
      ssu_id =  ssu_table.where(domains: {
        year: r["YEAR"], region: r["REGION"]
        }).where(strats: {
          strat: r["STRAT"], prot: r["PROT"]
          }).where(psus: {
            primary_sample_unit: r["PRIMARY_SAMPLE_UNIT"]
            }).where(ssus: {
              station_nr: r["STATION_NR"]
              }).pluck('ssus.id').first
       # Look up animal_id from species code
       animal_id = Animal.find_by_species_cd(r["SPECIES_CD"]).id
      # Insert sample into samples table
       conn.execute("INSERT INTO samples (ssu_id, num, len, time_seen, "\
       "animal_id, created_at, updated_at) VALUES (#{ssu_id},"\
       " #{r["NUM"]}, #{r["LEN"]}, #{r["TIME_SEEN"]},"\
       " #{animal_id}, '#{Time.now}', '#{Time.now}')")
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
