require 'csv'
namespace :benthic do
  desc "migrate benthic data to ssu"
  task migrate: :environment do
    file = ENV['file']
    puts "starting to migrate benthic data"
    # Set up table to query ssus
    ssu_table = Ssu.includes(psu: {strat: :domain})
    # Variables to track loop progress
    n = 0
    l = CSV.read(file).length
    t = Time.now
    # Loop through CSV update benthic attributes
    csv = CSV.foreach(file, :headers => true) do |r|
      # Get the ssu to which the current row belongs
      # may be
      ssu_id = ssu_table.where(domains: {
        year: r["YEAR"], region: r["REGION"]
        }).where(psus: {
          primary_sample_unit: r["PRIMARY_SAMPLE_UNIT"]
          }).where(ssus: {
            station_nr: r["STATION_NR"]
            }).pluck('ssus.id').first
      # Update attributes
      if (!ssu_id.nil?)
        ssu = Ssu.find(ssu_id)
        if (!ssu.update(
          max_hard_relief: r["max_hard_relief"],
          max_soft_relief: r["max_soft_relief"],
          avg_hard_relief: r["avg_hard_relief"],
          hard_rel_pct_0: r["hard_rel_pct_0"],
          hard_rel_pct_1: r["hard_rel_pct_1"],
          hard_rel_pct_2: r["hard_rel_pct_2"],
          hard_rel_pct_3: r["hard_rel_pct_3"],
          hard_rel_pct_4: r["hard_rel_pct_4"],
          pct_sand: r["pct_sand"], pct_hard_bottom: r["pct_hard_bottom"],
          pct_coral: r["pct_coral"], pct_octo: r["pct_octo"],
          pct_sponge: r["pct_sponge"], pct_rubble: r["pct_rubble"]
        ))
          errors = ssu.errors.full_messages
          raise "the following problems occured while trying to update the "\
           "ssu with the psu: #{r["PRIMARY_SAMPLE_UNIT"]} and station_nr: "\
           "#{r["STATION_NR"]} "\
           "#{errors.each{|m| puts m}}"
         end
       end

      # Track loop progress
      n += 1
      if n % (l.to_f/20).round == 0
        puts "#{(n.to_f/l * 100).round} percent complete"
        puts "ET: #{(Time.now - t).round} seconds elapsed"
      end
    end
    puts "finished migrating benthic data"
  end
end
