class LoadHistoricalWeather
  def load
    LoadWeather.new.load("http://dataservice.accuweather.com/currentconditions/v1/#{Rails.configuration.location_id}/historical/24?apikey=#{Rails.configuration.weather_api_key}")
  end
end
