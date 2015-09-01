require 'csv'
namespace :nm do
  task migrate: :environment do
    file = ENV['file'];
    csv = CSV.read(file, :headers => true)
    # Store the strat information for all rows
    s = []
    csv.each do |r|
      s << {year: r["YEAR"], region: r["REGION"], strat: r["STRAT"],
        prot: r["PROT"], n: r["n"], nm: r["nm"]}
    end
    # Get each unique strat
    strats = s.uniq
    # Set up join table
    strat_table = Strat.includes(:domain)
    # Find corresponding stratum in database and update it
    strats.each do |i|
      # Find stratum
      stratum = strat_table.where(domains: {year: i[:year], region: i[:region]}).
      where(strats: {strat: i[:strat], prot: i[:prot]}).first
      if stratum.nil?
        raise "stratum with year: #{i[:year]}, region: #{i[:region]},"\
        " strat: #{i[:strat]}, prot: #{i[:prot]} not found"
      end
      # update attributes
      stratum.update(n: i[:n], nm: i[:nm])
    end
  end
end
