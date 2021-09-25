require 'rails_helper'

RSpec.describe Metrics::Operations::FindById do
  describe '#call' do
    let!(:metric) { create(:metric, name: 'Employee Churn Rate') }
    let(:metric_id) { metric.id }

    context 'when metric is exists' do
      it 'returns success and metric record' do
        result = subject.call(metric_id)
        result_metric = result.success

        expect(result).to be_success
        expect(result_metric.id).to eq metric_id
      end
    end

    context 'when metric does not exists' do
      it 'returns failure and error message' do
        result = subject.call('none-existing-uuid')
        error, message = result.failure

        expect(result).to be_failure
        expect(error).to eq :not_found
        expect(message).to eq 'Metric not found'
      end
    end
  end
end
