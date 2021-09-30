require 'rails_helper'

RSpec.describe MetricValues::Operations::FilterByTimestamp do
  describe '#call' do
    let!(:metric) { create(:metric, name: 'Employee Churn Rate') }
    let!(:value) { create_list(:metric_value, 5, metric: metric, timestamp: DateTime.now) }
    let!(:past_seven_days_value) do
      create(
        :metric_value,
        metric: metric,
        timestamp: DateTime.now - 14.days
      )
    end

    let(:query) do
      {
        from: (DateTime.now - 7.days).beginning_of_day,
        to: DateTime.now.end_of_day
      }
    end

    it 'filters the collection by timestamp' do
      metric_values = metric.values
      result = subject.call(metric_values, query)

      expect(result).to be_success
      expect(result.success.size).to eq 5
    end
  end
end
