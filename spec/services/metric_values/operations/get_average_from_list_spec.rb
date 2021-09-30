require 'rails_helper'

RSpec.describe MetricValues::Operations::GetAverageFromList do
  describe '#call' do
    let!(:metric) { create(:metric, name: 'Employee Churn Rate') }
    let!(:values) do
      create_list(
        :metric_value,
        5,
        metric: metric,
        timestamp: DateTime.now,
        value: 100
      )
    end

    let(:query) do
      {
        from: (DateTime.now - 5.days).beginning_of_day,
        to: DateTime.now.end_of_day
      }
    end

    it 'returns average hash with minute, hour, and day values' do
      result = subject.call(values, query)
      average = result.success

      expect(result).to be_success
      expect(average[:per_minute].to_f).to eq 0.0694
      expect(average[:per_hour].to_f).to eq 4.17
      expect(average[:per_day].to_f).to eq 100.0
    end
  end
end
