require 'csv'
namespace :ar do
  desc "migrates psu/ssu/sample data from AR2.0 file"\
    " and inserts species richness for domain/strat/psu/ssu"
  task migrate: :environment do
    file = ENV["file"].to_s
    puts "starting to migrate file: #{file}"
    # Migrate data, if it fails clear the psus/ssu/samples entered
    begin
      Rake::Task['psu:migrate'].execute
      Rake::Task['ssu:migrate'].execute
      Rake::Task['sample:migrate'].execute
      Rake::Task['nm:migrate'].execute
      Rake::Task['diversity:generate'].execute
      puts "finished migrating file"
    rescue Exception => e
      csv = CSV.read(file, headers: true)
      d = []
      csv.each{|r| d << {year: r["YEAR"], region: r["REGION"]}}
      domains = d.uniq
      psu_table = Psu.includes(strat: :domain)
      puts "there was an error migrating the data"
      puts "cleaning up, this may take several minutes ..."
      domains.map do |i|
        psu_table.where(domains: {year: i[:year], region: i[:region]}).destroy_all
      end
      raise e
    end
  end
end
