class Api < Grape::API
  format :json

  get 'health' do
    { status: 'ok' }
  end

  namespace 'weather' do
    get :current do
      curent_weather = Weather.order(time: :desc).first
      { time: curent_weather.time.to_s, temperature: curent_weather.temperature }
    end

    get :historical do
      historical_weather = Weather.where(time: [Time.now-24.hours..Time.now]).order(time: :desc)
      historical_weather.each_with_object([]) do |weather, memo|
        memo << { time: weather.time.to_s, temperature: weather.temperature }
      end
    end

    get :max do
      max_weather = Weather.where(time: [Time.now-24.hours..Time.now]).order(temperature: :desc).first
      if max_weather
        { time: max_weather.time.to_s, temperature: max_weather.temperature }
      else
        error! 'Not Found', 404
      end
    end

    get :min do
      min_weather = Weather.where(time: [Time.now-24.hours..Time.now]).order(temperature: :asc).first
      if min_weather
        { time: min_weather.time.to_s, temperature: min_weather.temperature }
      else
        error! 'Not Found', 404
      end
    end

    get :avg do
      avg_weather = Weather.where(time: [Time.now-24.hours..Time.now]).average(:temperature)
      if avg_weather
        { temperature: avg_weather.round(1) }
      else
        error! 'Not Found', 404
      end
    end

    params do
      requires :time, type: String
    end
    get :by_time do
      time = DateTime.strptime(params[:time], '%s')
      time_span = 3.hours
      weathers = {}
      Weather.where(time: [time-time_span..time+time_span]).each { |i| weathers[(i.time.to_i - params[:time].to_i).abs] = i }
      historical_weather = weathers.sort_by { |k,v| k }.first
      if historical_weather
        { time: historical_weather.last.time.to_s, temperature: historical_weather.last.temperature }
      else
        error! 'Not Found', 404
      end
    end
  end
end
