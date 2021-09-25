require 'rails_helper'

RSpec.describe Metrics::Transactions::Create do
  describe '#call' do
    let(:create) { instance_double(Metrics::Operations::Persist) }
    let(:success) { Dry::Monads::Result::Success.new(:ok) }
    let(:subject) { described_class.new(create: create) }
    let(:params) { { name: 'CPU Utilization'} }

    describe 'when params are valid' do
      it 'should return a success monad' do
        expect(create).to receive(:call).with(params: params) { success }

        result = subject.call(params)
        expect(result).to be_success
      end
    end

    describe 'when params are invalid' do
      it 'should return a failure monad with contract level errors' do
        result = subject.call(params.except(:name))
        error, messages = result.failure

        expect(result).to be_failure
        expect(error).to eq :invalid_params
        expect(messages[:name]).to include 'is missing'
      end
    end
  end
end
