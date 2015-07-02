require 'csv'
namespace :benthic do
  desc "migrate benthic data to ssu"
  task migrate: :environment do
    file = ENV['file']
    puts "starting to migrate benthic data"
    # Set up connection to database
    conn = Domain.connection
    # Variables to track loop progress
    n = 0
    l = CSV.read(file).length
    t = Time.now
    # Loop through CSV update benthic attributes
    csv = CSV.foreach(file, :headers => true) do |r|
      # Get the ssu to which the current row belongs
      ssu = conn.execute("SELECT ssus.id FROM ssus, psus, strats, domains "\
      "WHERE ssus.psu_id = psus.id AND psus.strat_id = strats.id "\
      "AND strats.domain_id = domains.id AND "\
      "domains.year = #{r["YEAR"]} AND domains.region = '#{r["REGION"]}' "\
      "AND psus.primary_sample_unit = '#{r["PRIMARY_SAMPLE_UNIT"]}' "
      "AND ssus.station_nr = #{r["STATION_NR"]}")
      # Check that only 1 ssu selected
      if ssu.num_tuples != 1
        raise "more/less than 1 ssu found with the"\
        " psu: #{r["PRIMARY_SAMPLE_UNIT"]} and the"\
        " station_nr: #{r["STATION_NR"]}"
      end
      # Update attributes
      conn.execute("UPDATE ssus SET max_hard_relief = #{r["max_hard_relief"]},"\
      " max_soft_relief = #{r["max_soft_relief"]},"\
      " avg_hard_relief = #{r["avg_hard_relief"]},"\
      " hard_rel_pct_0 = #{r["hard_rel_pct_0"]},"\
      " hard_rel_pct_1 = #{r["hard_rel_pct_1"]},"\
      " hard_rel_pct_2 = #{r["hard_rel_pct_2"]},"\
      " hard_rel_pct_3 = #{r["hard_rel_pct_3"]},"\
      " hard_rel_pct_4 = #{r["hard_rel_pct_4"]}"\
      " pct_sand = #{r["pct_sand"]}"\
      " pct_hard_bottom = #{r["pct_hard_bottom"]}"\
      " pct_coral = #{r["pct_coral"]}"\
      " pct_octo = #{r["pct_octo"]}"\
      " pct_sponge = #{r["pct_sponge"]}"\
      " updated_at = '#{Time.now}'"
      " WHERE id = #{ssu[0]["id"].to_i}")
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
