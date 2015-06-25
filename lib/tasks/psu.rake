require 'csv'

namespace :psu do
  desc 'migrates new psus to database from AR file'
  task migrate: :environment do
    puts 'starting to migrate PSUs'
    file = ENV['file'].to_s
    csv = CSV.read(file, :headers=> true)
    p = []
    csv.each do |r|
      p << {year: r["YEAR"], region: r["REGION"], strat: r["STRAT"],
         prot: r["PROT"], month: r["MONTH"], day: r["DAY"],
         primary_sample_unit: r["PRIMARY_SAMPLE_UNIT"], zone_nr: r["ZONE_NR"],
         subregion_nr: r["SUBREGION_NR"], mapgrid_nr: r["MAPGRID_NR"],
         mpa_nr: r["MPA_NR"]}
    end
    # Store each unique psu
    psus = p.uniq
    # Establish a connection to the database
    conn = Domain.connection
    # Variables to track loop progress
    n = 0
    l = psus.length
    ## If valid, save each psu
    psus.each do |i|
      # Get the corresponding stratum
      s = conn.execute("SELECT strats.id FROM domains, strats WHERE"\
       " domains.id = strats.domain_id AND domains.year = #{i[:year]} "\
       "AND domains.region = '#{i[:region]}' AND strats.strat = '#{i[:strat]}'"\
       " AND strats.prot = #{i[:prot]}")
      if s.num_tuples != 1
        raise "more/less than 1 strats match input year: #{i[:year]}, "\
          "region: #{i[:region]}, strat: #{i[:strat]}, prot: #{i[:prot]}"
      end
      # Insert psus into psu table
      conn.execute("INSERT INTO psus (month, day, primary_sample_unit, "\
      "zone_nr, subregion_nr, mapgrid_nr, mpa_nr, strat_id, created_at,"\
       " updated_at) VALUES "\
      "(#{i[:month]},#{i[:day]},'#{i[:primary_sample_unit]}',"\
      "#{i[:zone_nr]},#{i[:subregion_nr]},#{i[:mapgrid_nr]},"\
      "#{i[:mpa_nr]},#{s[0]["id"].to_i},#{Time.now},#{Time.now})")
      # Track loop progress
      n += 1
      if n % (l.to_f/20).round == 0
        puts "#{(n.to_f/l * 100).round} percent complete"
      end
    end
    puts "done migrating PSUs"
  end
end
