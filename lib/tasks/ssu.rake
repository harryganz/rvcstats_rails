require 'csv'
namespace :ssu do
  desc 'migrates ssus from AR data'
  task migrate: :environment do
    puts "starting to migrate SSUs"
    file = ENV["file"].to_s
    # Read the csv file
    csv = CSV.read(file, :headers => true)
    ss = []
    # Get data for all SSUs, store in array of hashes
    csv.each do |r|
      ss << {year: r["YEAR"], region: r["REGION"], strat: r["STRAT"],
         prot: r["PROT"], primary_sample_unit: r["PRIMARY_SAMPLE_UNIT"],
         station_nr: r["STATION_NR"], lat_degrees: r["LAT_DEGREES"],
         lon_degrees: r["LON_DEGREES"], depth: r["DEPTH"],
         underwater_visibility: r["UNDERWATER_VISIBILITY"],
         habitat_cd: r["HABITAT_CD"]}
    end
    # Get unique set of SSUs
    ssus = ss.uniq
    # Establish connection to database
    conn = Domain.connection
    # Variables to track loop progress
    n = 0
    l = ssus.length
    t = Time.now
    # Save SSUs to database, if possible
    ssus.each do |i|
      # Get the ids for the domain, strat, and psu to which the ssu belongs
      p = conn.execute("SELECT psus.id FROM domains,"\
      " strats, psus WHERE domains.year = #{i[:year]} AND"\
      " domains.region = '#{i[:region]}' AND strats.strat = '#{i[:strat]}'"\
      " AND strats.prot = #{i[:prot]} AND domains.id = strats.domain_id"\
      " AND strats.id = psus.strat_id AND"\
      " psus.primary_sample_unit = '#{i[:primary_sample_unit]}'")
      if p.num_tuples != 1
        raise "more/less than 1 PSU found for SSU with year: #{i[:year]},"\
          " region: '#{i[:region]}', strat: '#{i[:strat]}', prot: #{i[:prot]},"\
          " psu: '#{i[:primary_sample_unit]}'"
      end
      # Save the SSU to the database
      conn.execute("INSERT INTO ssus (station_nr, lat_degrees, lon_degrees,"\
      " depth, underwater_visibility, habitat_cd, psu_id, created_at, "\
      " updated_at) VALUES (#{i[:station_nr]}, #{i[:lat_degrees]},"\
       "#{i[:lon_degrees]}, #{i[:depth]}, #{i[:underwater_visibility]},"\
       " '#{i[:habitat_cd]}',  #{p[0]["id"].to_i}, '#{Time.now}', '#{Time.now}')")
       # Track loop progress
       n += 1
       if n % (l.to_f/20).round == 0
         puts "#{(n.to_f/l * 100).round} percent complete"
         puts "ET: #{(Time.now-t).round} seconds elapsed"
       end
    end
    puts "finished migrating SSUs"
  end
end
