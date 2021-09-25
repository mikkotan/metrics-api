require 'rails_helper'

RSpec.describe Metrics::Transactions::Update do
  describe '#call' do
    let(:metric) { instance_double(Metric) }
    let(:find_metric) { instance_double(Metrics::Operations::FindById) }
    let(:update) { instance_double(Metrics::Operations::Persist) }

    let(:success) {  Dry::Monads::Result::Success.new(:ok) }
    let(:metric_monad) { Dry::Monads::Result::Success.new(metric) }

    let(:subject) { described_class.new(find_metric: find_metric, update: update) }
    let(:params) { { id: 'sample_uuid', name: 'Turnover Rate' } }

    context 'when params are valid' do
      it 'should return a success monad' do
        expect(find_metric).to receive(:call).with(params[:id]) { metric_monad }
        expect(update).to receive(:call).with(metric_record: metric, params:params) { success }

        result = subject.call(params)
        expect(result).to be_success
      end
    end

    context 'when params are invalid' do
      it 'should return failure with contract level errors' do
        result = subject.call(params.except(:id))
        error, messages = result.failure

        expect(result).to be_failure
        expect(error).to eq :invalid_params
        expect(messages[:id]).to include 'is missing'
      end
    end
  end
end
