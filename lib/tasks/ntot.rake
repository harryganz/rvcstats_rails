require 'csv'
namespace :ntot do
  desc "migrates strata and domains to database"
  task migrate: :environment do
    file = ENV['file'].to_s
    begin
      Rake::Task['domain:migrate'].execute
      Rake::Task['strat:migrate'].execute
    rescue Exception: e
      csv = CSV.read(file, headers: true)
      d = []
      csv.each{|r| d << {year: r["YEAR"], region: r["REGION"]}}
      domains = d.uniq
      Domain.where(domains).destroy_all
      puts e
    end
  end
end
