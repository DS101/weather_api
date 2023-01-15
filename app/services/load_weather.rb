class LoadWeather
  def load(url)
    response = HTTParty.get(url)
    response.parsed_response.each do |item|
      temperature = item["Temperature"]["Metric"]["Value"]
      time = DateTime.strptime(item["EpochTime"].to_s, '%s')
      next if Weather.where(time: time).exists?
      Weather.create(time: time, temperature: temperature)
    end
  end
end
