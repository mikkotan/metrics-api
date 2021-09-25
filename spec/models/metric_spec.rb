require 'rails_helper'

RSpec.describe Metric, type: :model do
  it { should validate_presence_of(:name) }
end
