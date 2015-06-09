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

    # Find all strata belonging the selected year and region, save to strata
    strata = Strat.where(year: year, region: region)
    if(strata.length == 0)
      raise("No strata found for year: #{year} and region: #{region}")
    end
    # Variables to track loop
    l = strata.length
    t = Time.now
    n = 0
    # While length strats > 0, select all samples belonging to one stratum,
    # and save to samples
    while strata.length > 0
      stratum = strata.first
      samples = stratum.samples
      # While length samples > 0, select all samples belonging to one ssu,
      # and save to selected
      while samples.length > 0
        sample = samples.first
        selected = samples.where(primary_sample_unit: sample.primary_sample_unit,
        station_nr: sample.station_nr)
        # Calculate richness for selected
        richness = calculate_richness(selected)
        # Intialize and save a diversity object for that ssu
        d = Diversity.new(primary_sample_unit: sample.primary_sample_unit,
        station_nr: sample.station_nr, richness: richness, strat_id: stratum.id)
        if d.valid?
          d.save
        else
          errors = d.errors.full_messages
          raise("diversity record could not be saved for the following reason(s):"\
          "#{errors}")
        end
        # Remove selected from samples (end inner loop)
        samples = samples.where.not(id: selected.pluck(:id))
      end
      # Remove stratum from strata (end outer loop)
      strata = strata.where.not(id: stratum.id)
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
  present = s.where('num > ?', 0)
  # Unique species in present
  species = present.pluck{:animal_id}.uniq
  # Return number of unique species
  return species.length
end
