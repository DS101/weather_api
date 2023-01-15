require 'rails_helper'

RSpec.describe 'health' do
  it 'status' do
    headers = { "ACCEPT" => "application/json" }
    reponse = get("/health", headers: headers)
    parsed_response = JSON.parse(response.body)
    expect(parsed_response).to eq({ "status" => "ok" })
  end
end
