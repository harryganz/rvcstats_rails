require 'csv'
require_relative './helpers.rb'
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
    ssus = ss.uniq{|v| [v[:year], v[:region], v[:primary_sample_unit],
      v[:station_nr]]}
    # Set up a table to query for PSUs
    psu_table = Psu.includes(strat: :domain)
    # Variables to track loop progress
    n = 0
    l = ssus.length
    t = Time.now
    # Save SSUs to database, if possible
    ssus.each do |i|
      # Get the id for the psu to which the ssu belongs
      psu_id = psu_table.where(domains: {
        year: i[:year], region: i[:region]
        }).where(strats: {
          strat: i[:strat], prot: i[:prot]
          }).where(psus: {
           primary_sample_unit: i[:primary_sample_unit]
          }).pluck('psus.id').first
       # Save the SSU to the database
       ssu = Ssu.new(station_nr: i[:station_nr], lat_degrees: i[:lat_degrees],
        lon_degrees: i[:lon_degrees], depth: i[:depth],
        underwater_visibility: i[:underwater_visibility],
        habitat_cd: i[:habitat_cd], psu_id: psu_id)
       if !ssu.save
         errors = ssu.errors.full_messages
         raise "There were the following problems in saving the ssu with the "\
          "psu_id: #{psu_id} and the station_nr: #{i[:station_nr]} "\
          "#{errors.each{|m| puts m}}"
        end
       # Track loop progress
       n += 1
       track_progress(n,l,t)
    end
    puts "finished migrating SSUs"
  end
end
