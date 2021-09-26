require 'rails_helper'

RSpec.describe Metrics::Transactions::Destroy do
  describe '#call' do
    let!(:metric) { create(:metric, name: 'First Metric') }
    let(:metric_id) { metric.id }

    context 'when there are no attached values to a metric' do
      it 'deletes the metric record' do
        result = subject.call(metric_id)
        deleted_metric_id = result.success[:deleted_metric_id]
        deleted_metric = Metric.where(id: deleted_metric_id).limit(1).first
  
        expect(result).to be_success
        expect(deleted_metric_id).to eq metric_id
        expect(deleted_metric).to eq nil
      end
    end

    context 'when there are attached metric values record' do
      let!(:values) { create_list(:metric_value, 5, metric: metric) }

      it 'returns success and deletes all attached values' do
        result = subject.call(metric_id)
        deleted_values = MetricValue.where(metric_id: metric_id)

        expect(result).to be_success
        expect(deleted_values).to be_empty
      end
    end
  end
end
