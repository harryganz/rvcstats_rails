amespace :diversity do
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
    samples_conn = Sample.connection
    strats_conn = Strat.connection

    # Select ids for all strata in year/region
    strata_ids = strats_conn.execute("SELECT strats.id FROM strats WHERE
     strats.year = #{year} AND strats.region = '#{region}'").map{|s| s["id"].to_i}
    # Raise error if no strata found
    if strata_ids.length == 0
      raise "no strats found for year: #{year} and region: #{region}"
    end

    # Select all samples in those strata
    domain_samples = samples_conn.execute("SELECT samples.id, samples.animal_id,
     samples.strat_id, samples.primary_sample_unit, samples.station_nr,
     samples.num FROM samples WHERE strat_id IN (#{strata_ids.join(',')})")

    # Calculate the richness for the domain
    domain_richness = calculate_richness(domain_samples)
    # Create and save DomainDiversity object
    dd = DomainDiversity.new(year: year, region: region,
     richness: domain_richness)
    saveIfValid(dd)

    # While strata still remain, pull off one stratum at a time
    while strata_ids.length > 0
      # Remove a stratum and save as strat_id
      strat_id = strata_ids.pop()
      # An array of the stratum_samples
      stratum_samples = domain_samples.select{
        |s| s["strat_id"].to_i == strat_id
      }
      # Remove stratum_samples from domain_samples
      domain_samples = domain_samples.select{
        |s| s["strat_id"].to_i != strat_id
      }
      # Calculate stratum richness
      stratum_richness = calculate_richness(stratum_samples)
      # Save stratum diversity object
      sd = StratumDiversity(strat_id: strat_id, domain_diversity_id: dd.id,
        richness: stratum_richness)
      saveIfValid(sd)

      # Get a list off all the PSUs in the stratum
      
    end

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

# Saves an active record object if valid or raises error
def saveIfValid(d)
  if d.valid?
    d.save
  else
    errors = d.errors.full_messages
    raise("diversity record could not be saved for the following reason(s):"\
    "#{errors}")
  end
end
