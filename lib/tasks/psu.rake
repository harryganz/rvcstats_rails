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
    # Variables to track loop progress
    n = 0
    l = psus.length
    ## Set up table to query from
    strat_table = Strat.includes(:domain)
    psus.each do |i|
      # Get the strat_id of the corresponding stratum
      strat_id = strat_table.where(domains: {year: i[:year],
        region: i[:region]}).where(strats: {strat: i[:strat],
          prot: i[:prot]}).pluck('strats.id').first
      # Initialize the PSU
      psu = Psu.new(month: i[:month], day: i[:day],
        primary_sample_unit: i[:primary_sample_unit], zone_nr: i[:zone_nr],
        subregion_nr: i[:subregion_nr], mapgrid_nr: i[:mapgrid_nr],
        mpa_nr: i[:mpa_nr], strat_id: strat_id)
      # Save if valid, else raise error
      if !psu.save
        errors = psu.error.full_messages
        raise "psu could not be saved for the following reasons"\
         "errors.each{|m| puts m}"
       end
      # Track loop progress
      n += 1
      if n % (l.to_f/20).round == 0
        puts "#{(n.to_f/l * 100).round} percent complete"
      end
    end
    puts "done migrating PSUs"
  end
end
