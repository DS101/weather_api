require 'rails_helper'

RSpec.describe LoadCurrentWeather do
  subject { described_class.new.load }
  it "loads current weather" do
    VCR.use_cassette("current_weather") do
      expect { subject }.to change { Weather.count }.by(1)

      weather = Weather.last
      expect(weather.time).to eq(Time.parse('2023-01-14T17:04:00+03:00'))
      expect(weather.temperature).to eq(-2.8)
    end
  end
end
