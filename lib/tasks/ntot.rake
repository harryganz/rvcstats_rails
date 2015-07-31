require 'csv'
namespace :ntot do
  desc "migrates strata and domains to database"
  task migrate: :environment do
    file = ENV['file'].to_s
    begin
      Rake::Task['domain:migrate'].execute
      Rake::Task['strat:migrate'].execute
    rescue Exception => e
      csv = CSV.read(file, headers: true)
      d = []
      csv.each{|r| d << {year: r["YEAR"], region: r["REGION"]}}
      domains = d.uniq
      puts "there was an error migrating the data"
      puts "cleaning up, this may take several minutes ..."
      domains.map do |i|
        Domain.where(year: i[:year], region: i[:region]).destroy_all
      end
      raise e
    end
  end
end
