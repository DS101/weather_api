FactoryBot.define do
  factory :weather do
    time { Time.now }
    temperature  { -1 }
  end
end
