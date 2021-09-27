require 'rails_helper'

RSpec.describe MetricValue, type: :model do
  it { should belong_to(:metric) }
end
