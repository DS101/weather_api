require 'rails_helper'

RSpec.describe 'weather' do
  let!(:weather1) { create(:weather, time: Time.now-2.day, temperature: 10) }
  let!(:weather2) { create(:weather, time: Time.now-12.hours, temperature: 5) }
  let!(:weather3) { create(:weather, time: Time.now-2.hours, temperature: -6) }

  describe 'current' do
    it "return the current temperature" do
      headers = { "ACCEPT" => "application/json" }
      reponse = get("/weather/current", headers: headers)
      parsed_response = JSON.parse(response.body).symbolize_keys
      expect(parsed_response).to eq({ time: weather3.time.to_s, temperature: weather3.temperature.to_s })
      expect(response.status).to eq(200)
    end
  end

  describe 'historical' do
    it "return last 24 hours history" do
      headers = { "ACCEPT" => "application/json" }
      reponse = get("/weather/historical", headers: headers)
      parsed_response = JSON.parse(response.body).map(&:symbolize_keys)
      expect(parsed_response).to eq([{ time: weather3.time.to_s, temperature: weather3.temperature.to_s }, { time: weather2.time.to_s, temperature: weather2.temperature.to_s }])
      expect(response.status).to eq(200)
    end
  end

  describe 'min' do
    it "return the min temperature" do
      headers = { "ACCEPT" => "application/json" }
      reponse = get("/weather/min", headers: headers)
      parsed_response = JSON.parse(response.body).symbolize_keys
      expect(parsed_response).to eq({ time: weather3.time.to_s, temperature: weather3.temperature.to_s })
      expect(response.status).to eq(200)
    end
  end

  describe 'max' do
    it "return the max temperature" do
      headers = { "ACCEPT" => "application/json" }
      reponse = get("/weather/max", headers: headers)
      parsed_response = JSON.parse(response.body).symbolize_keys
      expect(parsed_response).to eq({ time: weather2.time.to_s, temperature: weather2.temperature.to_s })
      expect(response.status).to eq(200)
    end
  end

  describe 'avg' do
    it "return the avg temperature" do
      headers = { "ACCEPT" => "application/json" }
      reponse = get("/weather/avg", headers: headers)
      parsed_response = JSON.parse(response.body).symbolize_keys
      expect(parsed_response).to eq({ temperature: "-0.5" })
      expect(response.status).to eq(200)
    end
  end

  describe 'by_time' do
    it "return temperature by time" do
      headers = { "ACCEPT" => "application/json" }
      reponse = get("/weather/by_time", headers: headers, params: { time: (Time.now - 50.hours).to_i })
      parsed_response = JSON.parse(response.body).symbolize_keys
      expect(parsed_response).to eq({ time: weather1.time.to_s, temperature: weather1.temperature.to_s })
      expect(response.status).to eq(200)
    end
  end
end
