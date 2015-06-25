require 'csv'
namespace :ar do
  desc "migrates psu/ssu/sample data from AR2.0 file"\
    " and inserts species richness for domain/strat/psu/ssu"
  task migrate: :environment do
    file = ENV["file"].to_s
    puts "starting to migrate file: #{file}"
    # Migrate data
    Rake::Task['psu:migrate'].invoke
    Rake::Task['ssu:migrate'].invoke
    Rake::Task['sample:migrate'].invoke

    # Calculate Diversity
    csv = CSV.read(file, :headers => true)
    domains = csv.map{|r| {year: r["YEAR"], region: r["REGION"]}}.uniq
    domains.each do |d|
      ENV["region"] = d[:region]
      ENV["year"] = d[:year]
      Rake::Task['diversity:generate']
    end
    puts "finished migrating file"
  end
end
