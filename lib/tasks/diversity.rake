namespace :diversity do
  desc "generates diversity data from sample data"

  # Generates diversity data from sample data for a given year
  # and region
  # Invariant: requires a valid year and region with
  # corresponding sample data available in the database
  task generate: :environment do
    puts "starting to calculate species richness"
    # Get year and region from environment variables
    file = ENV["file"] #get the file
    # Get the domains from the file
    domains = []
    CSV.read(file, :headers => true).each do |r|
      domains << {year: r["YEAR"], region: r["REGION"]}
    end
    domains = domains.uniq

    # Calculate richness for each domain
    domains.each do |d|
      domain = Domain.where(year: d[:year], region: d[:region]).first
      # Raise error if domain not found
      if domain.nil?
        raise "could not find domain with year: #{year} and region: #{region}"
      end
      # Calculate species richnesses
      domain.update(richness: calculate_richness(domain))
      domain.strats.each do |s|
        s.update(richness: calculate_richness(s))
        s.psus.each do |p|
          p.update(richness: calculate_richness(p))
          p.ssus.each do |ss|
            ss.update(richness: calculate_richness(ss))
          end
        end
      end
    end
    puts "finished calculating species richness"
  end
end

# Calculates number of unique species in s
def calculate_richness(s)
  # Select samples where individuals are present (num > 0)
  # and get the unique species
  species = s.samples.where("num > ?", 0).pluck(:animal_id).uniq
  # Return number of unique species
  return species.length
end
