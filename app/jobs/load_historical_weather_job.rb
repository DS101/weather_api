class LoadHistoricalWeatherJob < ApplicationJob
  def perform
    LoadHistoricalWeather.new.load
  end
end
