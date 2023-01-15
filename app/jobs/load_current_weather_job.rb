class LoadCurrentWeatherJob < ApplicationJob
  def perform
    LoadCurrentWeather.new.load
  end
end
