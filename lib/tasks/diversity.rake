namespace :diversity do
  desc "generates diversity data from sample data"

  # Generates diversity data from sample data for a given year
  # and region
  # Invariant: requires a valid year and region with
  # corresponding sample data available in the database
  task generate: :environment do
    puts "starting to calculate species richness"
    # Get year and region from environment variables
    year = ENV["YEAR"].to_i #get the year
    region = ENV["REGION"].to_s #get the region

    # Establish a connection to the database
    strats_conn = Strat.connection
    samples_conn = Sample.connection
    # Find all the strat_ids belonging to the year, region
    strata = strats_conn.execute("SELECT strats.id FROM strats WHERE
     year = #{year} AND region = '#{region}'").map{|s| s["id"]}
    if(strata.length == 0)
      raise("No strata found for year: #{year} and region: #{region}")
    end
    # Variables to track loop
    l = strata.length
    t = Time.now
    n = 0

    # While length strats > 0, pop off the last stratum and get all samples
    # belonging to it
    while strata.length > 0
      stratum = strata.pop
      samples = samples_conn.execute("SELECT samples.id FROM samples WHERE
      samples.strat_id = #{stratum}").map{|s| s["id"]}
      # While length samples > 0, select all samples belonging to one ssu,
      # and calculate richness, then remove ssu from samples
      while samples.length > 0
        sample = samples_conn.execute("SELECT primary_sample_unit, station_nr
         FROM samples WHERE id = #{samples[0]}")[0]
        selected = samples_conn.execute("SELECT id, animal_id, num FROM samples
        WHERE strat_id = #{stratum}
        AND primary_sample_unit = '#{sample["primary_sample_unit"]}'
        AND station_nr = #{sample["station_nr"]}")

        # Calculate richness for selected
        richness = calculate_richness(selected)
        # Intialize and save a diversity object for that ssu
        d = Diversity.new(primary_sample_unit: sample["primary_sample_unit"],
        station_nr: sample["station_nr"], richness: richness,
        strat_id: stratum)
        if d.valid?
          d.save
        else
          errors = d.errors.full_messages
          raise("diversity record could not be saved for the following reason(s):"\
          "#{errors}")
        end
        # Remove selected from samples
        samples = samples - selected.map{|k| k["id"]}
      end
      # Track loop progress
      n = n + 1
      puts "#{n} out of #{l} strata migrated"
      puts "ET: #{(Time.now - t).round} seconds"
    end
    puts "finished calculating species richness"
  end
end

# Calculates number of unique species in s
def calculate_richness(s)
  # Select samples where individuals are present (num > 0)
  present = s.select{|i| i["num"].to_i > 0}
  # Unique species in present
  species = present.map{|j| j["animal_id"]}.uniq
  # Return number of unique species
  return species.length
end
