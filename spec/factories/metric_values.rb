FactoryBot.define do
  factory :metric_value do
    timestamp { "2021-09-26 07:35:31" }
    value { 1.5 }
    metric { nil }
  end
end
