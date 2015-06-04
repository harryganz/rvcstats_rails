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
    # Query samples
    samples = Sample.includes(:stratum).where(strats: {year: year, region: region})
    # If no samples found, raise error
    if samples.length == 0
      raise "no samples found matching year and region"
    end

    # Variables to keep track of progress
    l = samples.length
    n = 0
    t = Time.now
    # Adds rows to diversities table
    while samples.length > 0
      # Select one sample not already selected
      sample = samples[1]
      # Select all samples in the same  SSU
      selected = samples.where(strat_id: sample.strat_id,
       primary_sample_unit: sample.primary_sample_unit,
       station_nr: sample.station_nr)
      # Calculate species richness for that SSU
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
      # Relate samples in SSU to diversity record
      d.samples = selected
      # remove SSU samples from samples object
      samples = samples.where.not(id: selected.map{|j| j.id})
       # Make a counter that counts off every 5% records
       n = n + 1
       if n % (l/20) == 0
         puts "#{(n.to_f/l * 100).ceil} percent complete"
         puts "ET: #{(Time.now - t).round(3)} seconds"
      end
    end
    puts "finished calculating species richness"
  end
end

# Calculates number of unique species in s
def calculate_richness(s)
  # Select samples where individuals are present (num > 0)
  present = s.where('num > ?', 0)
  # Unique species in present
  species = present.map{|i| i.animal_id}.uniq
  # Return number of unique species
  return species.length
end
