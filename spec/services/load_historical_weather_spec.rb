require 'rails_helper'

RSpec.describe LoadHistoricalWeather do
  subject { described_class.new.load }
  it "loads historical weather" do
    VCR.use_cassette("historical_weather") do
      expect { subject }.to change { Weather.count }.by(24)
    end
  end
end
