require 'rails_helper'

RSpec.describe MetricValues::Transactions::Create do
  describe '#call' do
    let(:validate_metric) { instance_double(Metrics::Operations::FindById) }
    let(:create) { instance_double(MetricValues::Operations::Persist) }
    let(:success) { Dry::Monads::Result::Success.new(:ok) }

    let(:subject) { described_class.new(validate_metric: validate_metric, create: create) }
    let(:params) { { metric_id: 'sample-uuid-1', timestamp: DateTime.now + 1.minute, value: 3.0 } }

    context 'when params are valid' do
      it 'should return a success monad' do
        expect(validate_metric).to receive(:call).with(params[:metric_id]) { success }
        expect(create).to receive(:call).with(params: params) { success }

        result = subject.call(params)
        expect(result).to be_success
      end
    end

    context 'when params are invalid' do
      it 'should return a failure monad with contract level errors' do
        result = subject.call(params.except(:metric_id))
        error, messages = result.failure

        expect(result).to be_failure
        expect(error).to eq :invalid_params
        expect(messages[:metric_id]).to include 'is missing'
      end
    end
  end
end
