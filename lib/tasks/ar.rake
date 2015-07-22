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
    Rake::Task['diversity:generate'].invoke
    puts "finished migrating file"
  end
end
