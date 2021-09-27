require 'rails_helper'

RSpec.describe Metric, type: :model do
  it { should have_many(:values) }
end
