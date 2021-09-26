require 'rails_helper'

RSpec.describe MetricValues::Transactions::Destroy do
  describe '#call' do
    let!(:metric) { create(:metric, name: 'CPU Downtime') }
    let!(:value) { create(:metric_value, metric: metric) }
    let(:metric_id) { metric.id }
    let(:value_id) { value.id }

    let(:validate_metric) { ->(_) { Dry::Monads::Result::Success.new(metric) } }
    let(:find_value) { ->(_) { Dry::Monads::Result::Success.new(value) } }

    let(:subject) do
      described_class.new(
        validate_metric: validate_metric,
        find_value: find_value
      )
    end

    let(:params) { { metric_id: metric_id, id: value_id } }
    it 'deletes the metric value record' do
      result = subject.call(params)
      deleted_result = result.success

      expect(result).to be_success
      expect(deleted_result[:id]).to eq value_id
      expect(deleted_result[:metric_id]).to eq metric_id
    end
  end
end
