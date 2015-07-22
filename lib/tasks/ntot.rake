namespace :ntot do
  desc "migrates strata and domains to database"
  task migrate: :environment do
    file = ENV['file'].to_s
    Rake::Task['domain:migrate'].invoke
    Rake::Task['strat:migrate'].invoke
  end
end
