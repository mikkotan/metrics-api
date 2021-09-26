require 'rails_helper'

RSpec.describe MetricValue, type: :model do
  it { should belong_to(:metric) }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:timestamp) }
end
