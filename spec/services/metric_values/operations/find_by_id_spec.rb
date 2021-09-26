require 'rails_helper'

RSpec.describe MetricValues::Operations::FindById do
  describe '#call' do
    let!(:metric) { create(:metric, name: 'Employee Churn Rate') }
    let!(:value) { create(:metric_value, metric: metric) }
    let(:value_id) { value.id }

    context 'when value record exists' do
      it 'return success and value record' do
        result = subject.call(value_id)
        result_value = result.success

        expect(result).to be_success
        expect(result_value.id).to eq value_id
      end
    end

    context 'when value record does not exists' do
      it 'return failure and error message' do
        result = subject.call('none-existing-uuid')
        error, message = result.failure

        expect(result).to be_failure
        expect(error).to eq :not_found
        expect(message).to eq 'Metric value not found'
      end
    end
  end
end
