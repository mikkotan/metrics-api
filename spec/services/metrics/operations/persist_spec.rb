require 'rails_helper'

RSpec.describe Metrics::Operations::Persist do
  describe '#call' do
    context 'when it is used for creating new metric record' do
      let(:new_attrs) { { name: 'CPU Utilization'} }

      context 'and when attributes are valid' do
        it 'should return success and create the new metric record' do
          result = subject.call(params: new_attrs)
          metric = result.success

          expect(result).to be_success
          expect(metric.name).to eq new_attrs[:name]
        end
      end

      context 'and when attributes are invalid' do
        it 'should return failure' do
          result = subject.call(params: new_attrs.except(:name))
          error, messages = result.failure

          expect(result).to be_failure
          expect(error).to eq :invalid_record
          expect(messages).to include "Name can't be blank"
        end
      end
    end

    context 'when it is used for update current metric record' do
      let!(:metric) { create(:metric, name: 'Server Downtimes') }
      let(:update_params) { { name: 'Server Uptime'} }

      it 'should update the record' do
        result = subject.call(params: update_params)
        metric = result.success

        expect(result).to be_success
        expect(metric.name).to eq update_params[:name]
      end
    end
  end
end
