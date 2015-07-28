require 'csv'
namespace :ar do
  desc "migrates psu/ssu/sample data from AR2.0 file"\
    " and inserts species richness for domain/strat/psu/ssu"
  task migrate: :environment do
    file = ENV["file"].to_s
    puts "starting to migrate file: #{file}"
    # Migrate data
    Rake::Task['psu:migrate'].execute
    Rake::Task['ssu:migrate'].execute
    Rake::Task['sample:migrate'].execute
    Rake::Task['diversity:generate'].execute
    puts "finished migrating file"
  end
end
