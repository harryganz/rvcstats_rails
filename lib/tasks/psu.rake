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
    ## If valid, save each psu
    psus.each do |i|
      d = Domain.where(year: i[:year], region: i[:region]).first
      s = Strat.where(domain_id: d.id, strat: i[:strat], prot: i[:prot]).first
      p = Psu.new(month: i[:month], day: i[:day],
        primary_sample_unit: i[:primary_sample_unit], zone_nr: i[:zone_nr],
        subregion_nr: i[:subregion_nr], mapgrid_nr: i[:mapgrid_nr],
        mpa_nr: i[:mpa_nr], strat_id: s.id)
      if !p.save
        errors = p.errors.full_messages
        raise "The PSU with the code: #{i[:primary_sample_unit]} could "\
          "not be saved for the following reasons: #{errors.each{|m| puts m}}"
      end
    end
    puts "done migrating PSUs"
  end
end
