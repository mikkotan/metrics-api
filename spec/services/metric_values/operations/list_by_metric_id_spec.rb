require 'rails_helper'

RSpec.describe MetricValues::Operations::ListByMetricId do
  describe '#call' do
    let!(:metric) { create(:metric) }
    let!(:values) { create_list(:metric_value, 5, metric: metric) }
    let(:metric_id) { metric.id }

    it 'return success monads with values' do
      result = subject.call(metric_id)
      result_values = result.success

      expect(result).to be_success
      expect(result_values.size).to eq values.size
    end
  end
end
