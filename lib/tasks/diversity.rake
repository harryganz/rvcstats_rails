namespace :diversity do
  desc "generates diversity data from sample data"

  # Generates diversity data from sample data for a given year
  # and region
  # Invariant: requires a valid year and region with
  # corresponding sample data available in the database
  task generate: :environment do
    t = Time.now
    puts "starting to calculate species richness"
    # Get year and region from environment variables
    year = ENV["YEAR"].to_i #get the year
    region = ENV["REGION"].to_s #get the region

    # Select samples belonging to the selected region/year
    strat_ids = Strat.where(year: year, region: region)
    samples = Sample.where(strat_id: strat_ids)
    puts "ET 1: #{Time.now - t}"
    # Raise error if no samples found
    if samples.length == 0
      raise "No samples found matching year: #{year} and region: #{region}"
    end

    # Variables to track progress of loop
    n = 0
    # Adds rows to diversities table
    while !samples.first.nil?
      puts "ET 2: #{Time.now - t}"
      sample = samples.first
      # Select all samples in the same  SSU
      selected = samples.where(strat_id: sample.strat_id,
      primary_sample_unit: sample.primary_sample_unit,
      station_nr: sample.station_nr)
     puts "ET 3: #{Time.now - t}"
      #Calculate species richness for that SSU
      richness = calculate_richness(selected)
      # Initialize a diversity instance: add psu, ssu, richness and samples
      # to diversity
      d = Diversity.new(
      strat_id: sample.strat_id,
      primary_sample_unit: sample.primary_sample_unit,
      station_nr: sample.station_nr,
      richness: richness)
      if d.valid?
        d.save
      else
        errors = d.errors.full_messages
        raise "the following errors occurred in saving the record with\n"\
        "strat_id: #{d.strat_id}, psu: #{d.primary_sample_unit},"\
        "station_nr: #{d.station_nr}\n"\
        "#{errors.each {|m| puts errors}}"
      end
      puts "ET 4: #{Time.now - t}"
      # Relate samples in SSU to diversity record
      d.samples = selected
      puts "ET 5: #{Time.now - t}"
      # Remove selected samples from samples list
      samples = samples.where.not(id: selected.pluck{:id})
      puts "ET 6: #{Time.now - t}"
    n += 1
    puts "#{n} SSUs sampled"
    puts "ET: #{(Time.now - t).round}"
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
