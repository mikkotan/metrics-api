FactoryBot.define do
  factory :metric do
    sequence(:name) { |n| "Metric #{n}" }
  end
end
