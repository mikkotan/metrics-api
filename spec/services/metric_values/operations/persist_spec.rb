require 'rails_helper'

RSpec.describe MetricValues::Operations::Persist do
  describe '#call' do
    let!(:metric) { create(:metric, name: 'Server Downtimes') }

    context 'create new record usage' do
      let(:attrs) do
        {
          timestamp: Time.now + 1.minute,
          value: 2.5,
          metric_id: metric.id
        }
      end

      context 'when attrs are valid' do
        it 'should return success and create the value record' do
          result = subject.call(params: attrs)
          value = result.success

          expect(result).to be_success
          expect(value.value).to eq attrs[:value]
        end
      end

      context 'when attrs are invalid' do
        it 'should return failure' do
          result = subject.call(params: attrs.except(:timestamp))
          error, messages = result.failure

          expect(result).to be_failure
          expect(error).to eq :invalid_record
          expect(messages).to include "Timestamp can't be blank"
        end
      end
    end

    context 'update existing record usage' do
      let!(:value) { create(:metric_value, timestamp: Time.now + 1.minute, value: 3, metric: metric) }
      let(:params) { { timestamp: Time.now + 5.minute, value: 1, metric_id: metric.id } }

      it 'should update the existing record' do
        result = subject.call(value_record: value, params: params)
        result_value = result.success

        expect(result).to be_success
        expect(result_value.value).to eq params[:value]
        expect(result_value.id).to eq value.id
      end
    end
  end
end
