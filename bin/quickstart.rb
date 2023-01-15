require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '10m' do
  LoadCurrentWeatherJob.perform_later
end

scheduler.every '24h' do
  LoadHistoricalWeatherJob.perform_later
end

scheduler.join
